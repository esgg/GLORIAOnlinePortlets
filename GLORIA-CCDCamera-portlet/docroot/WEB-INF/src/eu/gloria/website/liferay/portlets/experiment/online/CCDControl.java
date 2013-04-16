package eu.gloria.website.liferay.portlets.experiment.online;

import java.io.IOException;

import java.io.PrintWriter;
import java.text.DecimalFormat;
import java.text.DecimalFormatSymbols;
import java.util.HashMap;
import java.util.Hashtable;
import java.util.List;
import java.util.Locale;
import java.util.Properties;
import java.util.ResourceBundle;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.TimeUnit;

import javax.jws.WebService;
import javax.portlet.ActionRequest;
import javax.portlet.ActionResponse;
import javax.portlet.PortletException;
import javax.portlet.PortletPreferences;
import javax.portlet.PortletRequest;
import javax.portlet.PortletRequestDispatcher;
import javax.portlet.ProcessAction;
import javax.portlet.RenderRequest;
import javax.portlet.RenderResponse;
import javax.portlet.ResourceRequest;
import javax.portlet.ResourceResponse;
import javax.portlet.ValidatorException;
import javax.servlet.http.Cookie;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.liferay.portal.kernel.exception.PortalException;
import com.liferay.portal.kernel.exception.SystemException;
import com.liferay.portal.kernel.json.JSONFactoryUtil;
import com.liferay.portal.kernel.json.JSONObject;
import com.liferay.portal.kernel.servlet.SessionErrors;
import com.liferay.portal.kernel.servlet.SessionMessages;
import com.liferay.portal.kernel.util.ParamUtil;
import com.liferay.portal.kernel.util.Validator;
import com.liferay.portal.kernel.util.WebKeys;
import com.liferay.portal.model.User;
import com.liferay.portal.service.UserLocalServiceUtil;
import com.liferay.portal.theme.PortletDisplay;
import com.liferay.portal.theme.ThemeDisplay;
import com.liferay.util.bridges.mvc.MVCPortlet;

import eu.gloria.gs.services.experiment.online.OnlineExperimentException;
import eu.gloria.gs.services.experiment.online.data.NoSuchExperimentException;
import eu.gloria.gs.services.experiment.online.operations.ExperimentOperationException;
import eu.gloria.gs.services.experiment.online.operations.NoSuchOperationException;
import eu.gloria.gs.services.experiment.online.parameters.ExperimentParameterException;
import eu.gloria.gs.services.experiment.online.reservation.ExperimentNotInstantiatedException;
import eu.gloria.gs.services.experiment.online.reservation.NoSuchReservationException;
import eu.gloria.presentation.liferay.services.ExperimentHandler;
import eu.gloria.presentation.liferay.services.exception.ConnectionException;

public class CCDControl extends MVCPortlet {
	protected String editJSP;
	protected String viewJSP;
	protected String errorJSP;
	protected String errorImageUrl;

	// CCD Operations
	private static final String GET_VALUES = "getValues";
	private static final String SET_VALUES = "setValues";
	private static final String TAKE_IMAGE = "takeImage";

	// CCD Parameters
	private static final String BRIGHTNESS = "ccdBrightness";
	private static final String GAIN = "ccdGain";
	private static final String CONTRAST = "ccdContrast";
	private static final String EXPOSURE = "ccdExposure";
	private static final String DYNAMIC_URL = "dynamicUrl";
	private static final String STATIC_URL = "staticUrl";
	private static final String DYNAMIC_URL_WIDEFIELD = "dynamicUrlWidefield";

	private ExperimentHandler experiment = null;

	private Hashtable<String, String> operations = null;
	private Hashtable<String, String> parameters = null;

	private static Log log = LogFactory.getLog(CCDControl.class);
	private static ResourceBundle rb = ResourceBundle
			.getBundle("content.ccd.Language");

	private String width_default = "320";
	private String height_default = "240";

	private Integer timeSec = 10;

	private int reservationId = -1;

	private String urlImage = null;
	private String imageWidefieldUrl = null;

	public void init() throws PortletException {
		viewJSP = getInitParameter("view-jsp");
		editJSP = getInitParameter("edit-jsp");
		errorJSP = getInitParameter("error-jsp");
		errorImageUrl = getInitParameter("error-image-url");

		urlImage = errorImageUrl;
		imageWidefieldUrl = errorImageUrl;

		operations = new Hashtable<String, String>();
		parameters = new Hashtable<String, String>();

		super.init();
	}

	public void processAction(ActionRequest request, ActionResponse response)
			throws PortletException, IOException {
		// _log.info("EXECUTNG processAction");
		super.processAction(request, response);
	}

	@ProcessAction(name = "settingsForm")
	public void saveFormTab2(ActionRequest request, ActionResponse response)
			throws PortletException, IOException {
		// _log.info("");
		// _log.info("***saveFormTab2****");

		PortletPreferences prefs = request.getPreferences();

		String brightness = (String) request.getParameter("checkboxBrightness");
		if (Validator.isNull(brightness))
			brightness = "0";
		else
			brightness = "1";
		prefs.setValue("showBrightness", brightness);

		String gain = (String) request.getParameter("checkboxGain");
		if (Validator.isNull(gain))
			gain = "0";
		else
			gain = "1";
		prefs.setValue("showGain", gain);

		String exposure = (String) request.getParameter("checkboxExposure");
		if (Validator.isNull(exposure))
			exposure = "0";
		else
			exposure = "1";
		prefs.setValue("showExposure", exposure);

		String contrast = (String) request.getParameter("checkboxContrast");
		if (Validator.isNull(contrast))
			contrast = "0";
		else
			contrast = "1";
		prefs.setValue("showContrast", contrast);

		String takeImage = (String) request.getParameter("checkboxTake");
		if (Validator.isNull(takeImage))
			takeImage = "0";
		else
			takeImage = "1";
		prefs.setValue("showTakeImage", takeImage);

		String continousMode = (String) request.getParameter("checkboxCont");
		if (Validator.isNull(continousMode))
			continousMode = "0";
		else
			continousMode = "1";
		prefs.setValue("showContinousMode", continousMode);

		String width = ParamUtil.get(request, "widthCamField", width_default);
		String heigth = ParamUtil
				.get(request, "heightCamField", height_default);

		prefs.setValue("width", width);
		prefs.setValue("heigth", heigth);

		String reservationIdValue = (String) request
				.getParameter("reservationId");

		prefs.setValue("reservationId", reservationIdValue);

		prefs.store();

		reservationId = Integer.parseInt(reservationIdValue);
	}

	public void doView(RenderRequest request, RenderResponse response)
			throws PortletException, IOException {
		// _log.info("");
		// _log.info("***EXECUTNG doView****");

		ThemeDisplay themeDisplay = (ThemeDisplay) request
				.getAttribute(WebKeys.THEME_DISPLAY);
		PortletDisplay portletDisplay = themeDisplay.getPortletDisplay();
		String portletId = portletDisplay.getId();

		log.info("Rendering CCDCamera portlet:" + portletId);

		PortletPreferences prefs = request.getPreferences();

		reservationId = Integer.parseInt((String) prefs.getValue(
				"reservationId", "-1"));

		log.info("Configuring operations and parameters of experiment");

		operations = new Hashtable<String, String>();
		parameters = new Hashtable<String, String>();

		experiment = new ExperimentHandler();

		log.info("Mapping available operations");

		// Operation to get ccd values

		String operation = "load_ccd_attributes00";
		log.info("Operation detected:" + operation);
		operations.put(GET_VALUES, operation);

		// Operation to set ccd values
		operation = "save_ccd_attributes00";
		log.info("Operation detected:" + operation);
		operations.put(SET_VALUES, operation);

		// Operation to take image
		operation = "take_jpg_image00";
		log.info("Operation detected:" + operation);
		operations.put(TAKE_IMAGE, operation);

		log.info("Mapping available parameters");

		String parameter = "ccd_cont_url00";
		log.info("Parameter " + parameter + " detected");
		parameters.put(DYNAMIC_URL, parameter);

		parameter = "ccd_cont_url01";
		log.info("Parameter " + parameter + " detected");
		parameters.put(DYNAMIC_URL_WIDEFIELD, parameter);

		parameter = "ccd_inst_jpg_url00";
		log.info("Parameter " + parameter + " detected");
		parameters.put(STATIC_URL, parameter);

		parameter = "ccd_brightness00";
		log.info("Parameter " + parameter + " detected");
		parameters.put(BRIGHTNESS, parameter);

		parameter = "ccd_gain00";
		log.info("Parameter " + parameter + " detected");
		parameters.put(GAIN, parameter);

		parameter = "ccd_contrast00";
		log.info("Parameter " + parameter + " detected");
		parameters.put(CONTRAST, parameter);

		parameter = "ccd_exposure00";
		log.info("Parameter " + parameter + " detected");
		parameters.put(EXPOSURE, parameter);

		if (urlImage == null || urlImage.equals(errorImageUrl)) {
			try {
				User currentUser = UserLocalServiceUtil.getUserById(Long
						.parseLong(request.getRemoteUser()));

				String urlImageParameter = (String) experiment
						.getParameterValue(parameters.get(DYNAMIC_URL),
								currentUser.getEmailAddress(),
								currentUser.getPassword(), reservationId);
				if (urlImageParameter != null) {
					urlImage = urlImageParameter;
					log.info("URL for narrow ccd camera loaded:" + urlImage);
				} else {
					urlImage = errorImageUrl;
					log.info("URL for narrow ccd  camera not detected");
				}

				urlImageParameter = (String) experiment.getParameterValue(
						parameters.get(DYNAMIC_URL_WIDEFIELD),
						currentUser.getEmailAddress(),
						currentUser.getPassword(), reservationId);
				if (urlImageParameter != null) {
					imageWidefieldUrl = urlImageParameter;
					log.info("URL for widefield ccd camera loaded:" + urlImage);
				} else {
					imageWidefieldUrl = errorImageUrl;
					log.info("URL for widefield ccd camera not detected");
				}

			} catch (NumberFormatException e) {
				urlImage = errorImageUrl;
				imageWidefieldUrl = errorImageUrl;
				log.info("Unformat user id:" + e.getMessage());
			} catch (PortalException e) {
				urlImage = errorImageUrl;
				imageWidefieldUrl = errorImageUrl;
				log.info("Portal exception to get user:" + e.getMessage());
			} catch (SystemException e) {
				urlImage = errorImageUrl;
				imageWidefieldUrl = errorImageUrl;
				log.info("SystemException to get user:" + e.getMessage());
			} catch (ConnectionException e) {
				urlImage = errorImageUrl;
				imageWidefieldUrl = errorImageUrl;
				log.info("Connection problem:" + e.getMessage());
			} catch (ExperimentOperationException e) {
				urlImage = errorImageUrl;
				imageWidefieldUrl = errorImageUrl;
				log.info("Operation Exception:" + e.getMessage());
			} catch (NoSuchOperationException e) {
				urlImage = errorImageUrl;
				imageWidefieldUrl = errorImageUrl;
				log.info("No such operation:" + e.getMessage());
			} catch (ExperimentParameterException e) {
				urlImage = errorImageUrl;
				imageWidefieldUrl = errorImageUrl;
				log.info("Parameter error:" + e.getMessage());
			} catch (ExperimentNotInstantiatedException e) {
				urlImage = errorImageUrl;
				imageWidefieldUrl = errorImageUrl;
				log.info("Experiment not instantiated:" + e.getMessage());
			} catch (OnlineExperimentException e) {
				urlImage = errorImageUrl;
				imageWidefieldUrl = errorImageUrl;
				log.info("Online Experiment Exception:" + e.getMessage());
			} catch (NoSuchReservationException e) {
				urlImage = errorImageUrl;
				imageWidefieldUrl = errorImageUrl;
				log.info("Reservation no such:" + e.getMessage());
			} catch (NoSuchExperimentException e) {
				urlImage = errorImageUrl;
				imageWidefieldUrl = errorImageUrl;
				log.info("No such experiment:" + e.getMessage());
			}
		}

		// request.setAttribute("reservationId", reservationId);

		request.setAttribute("prefsURL", urlImage);
		request.setAttribute("widefieldURL", imageWidefieldUrl);
		// request.setAttribute("prefsURL", errorImageUrl);

		/* CONFIGURATION */
		// String configured = (String) prefs.getValue("configured", "false");
		// request.setAttribute("configured", configured);

		/* SIZE OF IMAGE */
		String prefsWidth = (String) prefs.getValue("width", "320");
		String prefsHeight = (String) prefs.getValue("heigth", "240");

		try {
			if (Integer.parseInt(prefsWidth) <= 0
					|| Integer.parseInt(prefsWidth) >= 1000
					|| prefsWidth.equalsIgnoreCase(""))
				prefsWidth = "320";
		} catch (Exception err) {
			prefsWidth = "320";
		}

		try {
			if (Integer.parseInt(prefsHeight) <= 0
					|| Integer.parseInt(prefsHeight) >= 1000
					|| prefsHeight.equalsIgnoreCase(""))
				prefsHeight = "240";
		} catch (Exception err) {
			prefsHeight = "240";
		}

		String width = prefsWidth;
		String height = prefsHeight;
		Cookie[] cookieList = request.getCookies();
		for (int I = 0; I < cookieList.length; I++) {
			Cookie myCookie = cookieList[I];
			if (myCookie.getName().equals("_" + portletId + "_width"))
				width = myCookie.getValue();
			if (myCookie.getName().equals("_" + portletId + "_height"))
				height = myCookie.getValue();
		}
		request.setAttribute("prefsWidth", width);
		request.setAttribute("prefsHeight", height);
		/* END - SIZE OF IMAGE */

		/* SHOWS */
		String checkboxBrightness = (String) prefs.getValue("showBrightness",
				"0");

		request.setAttribute("checkboxBrightness", checkboxBrightness);

		String checkboxGain = (String) prefs.getValue("showGain", "0");
		request.setAttribute("checkboxGain", checkboxGain);

		String checkboxExposure = (String) prefs.getValue("showExposure", "0");
		request.setAttribute("checkboxExposure", checkboxExposure);

		String checkboxTake = (String) prefs.getValue("showTakeImage", "0");
		request.setAttribute("checkboxTake", checkboxTake);

		String checkboxCont = (String) prefs.getValue("showContinousMode", "0");
		request.setAttribute("checkboxCont", checkboxCont);

		String checkboxContrast = (String) prefs.getValue("showContrast", "0");
		request.setAttribute("checkboxContrast", checkboxContrast);

		/* VALUES */
		String brightness_value = (String) prefs.getValue("brightness_value",
				"error");
		request.setAttribute("brightness_value", brightness_value);

		String gain_value = (String) prefs.getValue("gain_value", "error");
		request.setAttribute("gain_value", gain_value);

		String expT_value = (String) prefs.getValue("expT_value", "error");
		request.setAttribute("expT_value", expT_value);

		String contrast_value = (String) prefs.getValue("contrast_value",
				"error");
		request.setAttribute("contrast_value", contrast_value);

		include(viewJSP, request, response);
	}

	public void doEdit(RenderRequest request, RenderResponse response)
			throws PortletException, IOException {
		// _log.info("");
		// _log.info("***EXECUTNG doEdit****");

		PortletPreferences prefs = request.getPreferences();

		/* TAB 1 */

		String prefsURL = (String) prefs.getValue("url",
				rb.getString("label-none"));
		if (prefsURL.equalsIgnoreCase("None"))
			prefsURL = errorImageUrl;
		request.setAttribute("prefsURL", prefsURL);

		String prefsCoord = (String) prefs.getValue(
				"location",
				rb.getString("label-default-ra-coordinates") + ","
						+ rb.getString("label-default-dec-coordinates"));
		request.setAttribute("prefsLocation", prefsCoord);

		String prefsWidth = (String) prefs.getValue("width", width_default);
		request.setAttribute("prefsWidth", prefsWidth);

		String prefsHeight = (String) prefs.getValue("height", height_default);
		request.setAttribute("prefsHeight", prefsHeight);

		/* TAB 2 */
		String prefsBrightness = (String) prefs.getValue("showBrightness", "0");
		request.setAttribute("checkboxBrightness", prefsBrightness);

		String prefsGain = (String) prefs.getValue("showGain", "0");
		request.setAttribute("checkboxGain", prefsGain);

		String prefsExposure = (String) prefs.getValue("showExposure", "0");
		request.setAttribute("checkboxExposure", prefsExposure);

		String prefsContrast = (String) prefs.getValue("showContrast", "0");
		request.setAttribute("checkboxContrast", prefsContrast);

		String prefsTakeImage = (String) prefs.getValue("showTakeImage", "0");
		request.setAttribute("checkboxTake", prefsTakeImage);

		String prefsContinous = (String) prefs.getValue("showContinousMode",
				"0");
		request.setAttribute("checkboxCont", prefsContinous);

		// String reservationIdValue = (String) request
		// .getParameter("reservationId");
		//
		// prefs.setValue("reservationId", reservationIdValue);
		//
		// reservationId = Integer.parseInt(reservationIdValue);

		include(editJSP, request, response);
	}

	/*
	 * 
	 * AJAX CALLS
	 */
	@Override
	public void serveResource(ResourceRequest request, ResourceResponse response)
			throws PortletException, IOException {
		// _log.info("");
		// _log.info("***EXECUTNG serveResource****");

		final PortletPreferences prefs = request.getPreferences();
		final JSONObject jsonObject = JSONFactoryUtil.createJSONObject();
		String mode = ParamUtil.get(request, "control", "null");

		log.info("Request from browser:" + mode);

		User currentUser;

		try {
			currentUser = UserLocalServiceUtil.getUserById(Long
					.parseLong(request.getRemoteUser()));

			log.info("User:" + currentUser.getEmailAddress() + " requieres:"
					+ mode);

			if (mode.equals("operation")) {
				jsonObject.put("success", true);

				String urlImageParameter = (String) experiment
						.getParameterValue(parameters.get(DYNAMIC_URL),
								currentUser.getEmailAddress(),
								currentUser.getPassword(), reservationId);
				if (urlImageParameter != null) {
					urlImage = urlImageParameter;
					log.info("URL for surveillance camera loaded:" + urlImage);
				} else {
					urlImage = errorImageUrl;
					log.info("URL for surveillance camera not detected");
				}

				log.info("Serve image:" + urlImage);
				jsonObject.put("url", urlImage);

			} else if (mode.equals("widefieldUrl")) {

				String urlImageParameter = (String) experiment
						.getParameterValue(
								parameters.get(DYNAMIC_URL_WIDEFIELD),
								currentUser.getEmailAddress(),
								currentUser.getPassword(), reservationId);
				if (urlImageParameter != null) {
					jsonObject.put("success", true);
					log.info("URL for surveillance camera loaded:"
							+ urlImageParameter);
				} else {
					jsonObject.put("success", false);
					urlImageParameter = errorImageUrl;
					log.info("URL for surveillance camera not detected");
				}

				log.info("Serve image:" + urlImageParameter);
				jsonObject.put("url", urlImageParameter);
			}
			/*
			 * SET VALUES
			 */
			if (mode.equals("setValues")) {
				String brightness = ParamUtil.get(request, "brightness",
						"error");
				String gain = ParamUtil.get(request, "gain", "error");
				String exposure = ParamUtil.get(request, "exposure", "error");

				if (!brightness.equals("error") && !gain.equals("error")
						&& !exposure.equals("error")) {

					experiment.setParameterValue(parameters.get(BRIGHTNESS),
							Integer.parseInt(brightness),
							currentUser.getEmailAddress(),
							currentUser.getPassword(), reservationId);
					experiment.setParameterValue(parameters.get(GAIN),
							Integer.parseInt(gain),
							currentUser.getEmailAddress(),
							currentUser.getPassword(), reservationId);
//					experiment.setParameterValue(parameters.get(CONTRAST),
//							Integer.parseInt(contrast),
//							currentUser.getEmailAddress(),
//							currentUser.getPassword(), reservationId);
					experiment.setParameterValue(parameters.get(EXPOSURE),
							Double.parseDouble(exposure),
							currentUser.getEmailAddress(),
							currentUser.getPassword(), reservationId);

					experiment.executeOperation(operations.get(SET_VALUES),
							currentUser.getEmailAddress(),
							currentUser.getPassword(), reservationId);
					log.info("Save Parameters:" + "[B=" + brightness + ",G="
							+ gain + ",E=" + exposure);
					jsonObject.put("success", true);
				}

			}

			/*
			 * GET VALUES
			 */
			if (mode.equals("getValues")) {
				int brightness_value;
				int gain_value;
				int contrast_value;
				double exposure_value;

				log.info("Getting values");

				experiment.executeOperation(operations.get(GET_VALUES),
						currentUser.getEmailAddress(),
						currentUser.getPassword(), reservationId);

				brightness_value = (Integer) experiment.getParameterValue(
						parameters.get(BRIGHTNESS),
						currentUser.getEmailAddress(),
						currentUser.getPassword(), reservationId);
				gain_value = (Integer) experiment.getParameterValue(
						parameters.get(GAIN), currentUser.getEmailAddress(),
						currentUser.getPassword(), reservationId);
				contrast_value = (Integer) experiment.getParameterValue(
						parameters.get(CONTRAST),
						currentUser.getEmailAddress(),
						currentUser.getPassword(), reservationId);
				exposure_value = (Double) experiment.getParameterValue(
						parameters.get(EXPOSURE),
						currentUser.getEmailAddress(),
						currentUser.getPassword(), reservationId);

				log.info("Load Parameters:" + "[B=" + brightness_value + ",G="
						+ gain_value + ",C=" + contrast_value + ",E="
						+ exposure_value);
				jsonObject.put("brightness", String.valueOf(brightness_value));
				jsonObject.put("gain", String.valueOf(gain_value));
				jsonObject.put("exposure", String.valueOf(exposure_value));
				jsonObject.put("contrast", String.valueOf(contrast_value));
				jsonObject.put("success", true);

			}

			if (!mode.equals("popup")) {
				PrintWriter writer = response.getWriter();
				writer.write(jsonObject.toString());
			}

		} catch (NumberFormatException e) {
			log.error("Error in number format:" + e.getMessage());
			jsonObject.put("success", false);
			jsonObject.put("message", "error_execution");
		} catch (PortalException e) {
			log.error("Error in portal:" + e.getMessage());
			jsonObject.put("success", false);
			jsonObject.put("message", "error_execution");
		} catch (SystemException e) {
			log.error("Error in system" + e.getMessage());
			jsonObject.put("success", false);
			jsonObject.put("message", "error_execution");
		} catch (ConnectionException e) {
			log.error("Problem with a connection:" + e.getMessage());
			jsonObject.put("success", false);
			jsonObject.put("message", "error_execution");
		} catch (ExperimentOperationException e) {
			log.error("Failed in operation:" + e.getMessage());
			jsonObject.put("success", false);
			jsonObject.put("message", "error_execution");
		} catch (NoSuchOperationException e) {
			log.error("Invalid operation:" + e.getMessage());
			jsonObject.put("success", false);
			jsonObject.put("message", "error_execution");
		} catch (ExperimentParameterException e) {
			log.error("Problem with parameter:" + e.getMessage());
			jsonObject.put("success", false);
			jsonObject.put("message", "error_execution");
		} catch (ExperimentNotInstantiatedException e) {
			log.error("Not exist reservation:" + reservationId + "->"
					+ e.getMessage());
			jsonObject.put("success", false);
			jsonObject.put("message", "error_reservation_not_active");
		} catch (OnlineExperimentException e) {
			log.error("Error to store new values" + e.getMessage());
			jsonObject.put("success", false);
			jsonObject.put("message", "error_execution");
		} catch (NoSuchReservationException e) {
			log.error("Problem with parameter invalid experiment:"
					+ e.getMessage());
			jsonObject.put("success", false);
			jsonObject.put("message", "error_reservation_null");
		} catch (NoSuchExperimentException e) {
			log.error("Problem with a experiment:" + e.getMessage());
			jsonObject.put("success", false);
			jsonObject.put("message", "error_execution");
		}

		/*
		 * POPUP
		 */
		if (mode.equals("popup")) {
			String exposure = ParamUtil.get(request, "exposure", "0");
			String popUpJsp = getInitParameter("popup-jsp");

			String popup = null;
			String fitsImage = null;

			log.info("Taking instantaneous image");
			try {
				currentUser = UserLocalServiceUtil.getUserById(Long
						.parseLong(request.getRemoteUser()));
				experiment.executeOperation(operations.get(TAKE_IMAGE),
						currentUser.getEmailAddress(),
						currentUser.getPassword(), reservationId);
				popup = (String) experiment.getParameterValue(
						parameters.get(STATIC_URL),
						currentUser.getEmailAddress(),
						currentUser.getPassword(), reservationId);
				log.info("Image taken:" + popup);

				// TODO Check if popup is null
				if (popup == null) {
					popup = errorImageUrl;
					fitsImage = popup;
					request.setAttribute("errorImage", "error");
				} else {
					int ipMachine = popup.indexOf(":8080/");
					fitsImage = popup.substring(0, ipMachine + 6)
							+ "RTD_TAD_DB/ServletImage?fileName="
							+ popup.substring(popup.lastIndexOf("/") + 1)
									.replaceAll(".jpg", ".fits");
					request.setAttribute("errorImage", "ok");
				}

			} catch (ConnectionException e) {
				popup = errorImageUrl;
				fitsImage = errorImageUrl;
				request.setAttribute("errorImage", "error");
				log.error("Problem with a connection:" + e.getMessage());
			} catch (ExperimentOperationException e) {
				popup = errorImageUrl;
				fitsImage = errorImageUrl;
				request.setAttribute("errorImage", "error");
				log.error("Failed in operation:" + e.getMessage());
			} catch (NoSuchOperationException e) {
				popup = errorImageUrl;
				fitsImage = errorImageUrl;
				request.setAttribute("errorImage", "error");
				log.error("Invalid operation:" + e.getMessage());
			} catch (ExperimentParameterException e) {
				popup = errorImageUrl;
				fitsImage = errorImageUrl;
				request.setAttribute("errorImage", "error");
				log.error("Problem with parameter:" + e.getMessage());
			} catch (ExperimentNotInstantiatedException e) {
				popup = errorImageUrl;
				fitsImage = errorImageUrl;
				request.setAttribute("errorImage", "error");
				log.error("Not exist reservation:" + reservationId + "->"
						+ e.getMessage());
			} catch (OnlineExperimentException e) {
				popup = errorImageUrl;
				fitsImage = errorImageUrl;
				request.setAttribute("errorImage", "error");
				log.error("Error to store new values" + e.getMessage());
			} catch (NoSuchReservationException e) {
				log.error("Problem with parameter invalid experiment:"
						+ e.getMessage());
				popup = errorImageUrl;
				fitsImage = errorImageUrl;
				request.setAttribute("errorImage", "error");
			} catch (NoSuchExperimentException e) {
				log.error("Problem with a experiment:" + e.getMessage());
				popup = errorImageUrl;
				fitsImage = errorImageUrl;
				request.setAttribute("errorImage", "error");
			} catch (NumberFormatException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (PortalException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (SystemException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

			request.setAttribute("popupImgURL", popup);
			request.setAttribute("popupImgFits", fitsImage);

			include(popUpJsp, request, response, PortletRequest.RESOURCE_PHASE);
		}

	}

	protected void include(String path, RenderRequest renderRequest,
			RenderResponse renderResponse) throws IOException, PortletException {
		PortletRequestDispatcher portletRequestDispatcher = getPortletContext()
				.getRequestDispatcher(path);
		if (portletRequestDispatcher == null) {
			log.error(path + " is not a valid include");
		} else {
			portletRequestDispatcher.include(renderRequest, renderResponse);
		}
	}
}
