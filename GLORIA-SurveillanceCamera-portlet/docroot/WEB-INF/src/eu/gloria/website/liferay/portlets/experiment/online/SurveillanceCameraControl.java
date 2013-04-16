package eu.gloria.website.liferay.portlets.experiment.online;

import java.io.IOException;

import java.io.PrintWriter;
import java.util.ResourceBundle;

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

public class SurveillanceCameraControl extends MVCPortlet {
	protected String viewJSP;
	protected String editJSP;
	protected String errorJSP;
	protected String errorImageUrl;

	private static Log log = LogFactory.getLog(SurveillanceCameraControl.class);
	private static ResourceBundle rb = ResourceBundle
			.getBundle("content.webcamera.Language");

	private String width_default = "320";
	private String height_default = "240";

	private Integer timeSec = 10;

	private ExperimentHandler experiment = null;

	private int reservationId = -1;

	private String operation_parameter = null;

	private String urlImage = null;

	public void init() throws PortletException {
		viewJSP = getInitParameter("view-jsp");
		errorJSP = getInitParameter("error-jsp");
		errorImageUrl = getInitParameter("error-image-url");
		urlImage = errorImageUrl;
		super.init();
	}

	@ProcessAction(name = "settingsForm")
	public void settingsForm(ActionRequest request, ActionResponse response)
			throws PortletException, IOException {
		// _log.info("");
		// _log.info("***saveFormTab2****");

		PortletPreferences prefs = request.getPreferences();

		String reservationIdValue = (String) request
				.getParameter("reservationId");

		prefs.setValue("reservationId", reservationIdValue);

		prefs.store();

		reservationId = Integer.parseInt(reservationIdValue);
	}

	public void processAction(ActionRequest request, ActionResponse response)
			throws PortletException, IOException {
		// _log.info("EXECUTNG processAction");
		super.processAction(request, response);
	}

	public void doView(RenderRequest request, RenderResponse response)
			throws PortletException, IOException {
		// _log.info("");
		// _log.info("***EXECUTNG doView****");

		ThemeDisplay themeDisplay = (ThemeDisplay) request
				.getAttribute(WebKeys.THEME_DISPLAY);
		PortletDisplay portletDisplay = themeDisplay.getPortletDisplay();
		String portletId = portletDisplay.getId();

		log.info("Rendering portlet:" + portletId);

		PortletPreferences prefs = request.getPreferences();

		reservationId = Integer.parseInt((String) prefs.getValue(
				"reservationId", "-1"));

		log.info("Render surveillance camera with reservation id:"
				+ reservationId);

		try {
			User currentUser = UserLocalServiceUtil.getUserById(Long
					.parseLong(request.getRemoteUser()));
			log.info("Mapping parameters");
			experiment = new ExperimentHandler();
			log.info("Reservation:" + reservationId);

			operation_parameter = "stream_url00";

			log.info("Parameter " + operation_parameter + " detected");
			String urlImageParameter = (String) experiment
					.getParameterValue(operation_parameter,
							currentUser.getEmailAddress(),
							currentUser.getPassword(), reservationId);
			if (urlImageParameter != null) {
				urlImage = urlImageParameter;
				log.info("URL for surveillance camera loaded:" + urlImage);
			} else {
				urlImage = errorImageUrl;
				log.info("URL for surveillance camera not detected");
			}


		} catch (NumberFormatException e) {
			urlImage = errorImageUrl;
			log.error("Unformat user id:" + e.getMessage());
		} catch (PortalException e) {
			urlImage = errorImageUrl;
			log.error("Portal exception to get user:" + e.getMessage());
		} catch (SystemException e) {
			urlImage = errorImageUrl;
			log.error("SystemException to get user:" + e.getMessage());
		} catch (OnlineExperimentException e) { // Preguntar Fernando
			urlImage = errorImageUrl;
			e.printStackTrace();
		} catch (NoSuchExperimentException e) {
			urlImage = errorImageUrl;
			e.printStackTrace();
		} catch (ConnectionException e) {
			urlImage = errorImageUrl;
			e.printStackTrace();
		} catch (ExperimentOperationException e) {
			urlImage = errorImageUrl;
			e.printStackTrace();
		} catch (NoSuchOperationException e) {
			urlImage = errorImageUrl;
			e.printStackTrace();
		} catch (ExperimentParameterException e) {
			urlImage = errorImageUrl;
			e.printStackTrace();
		} catch (ExperimentNotInstantiatedException e) {
			urlImage = errorImageUrl;
			e.printStackTrace();
		} catch (NoSuchReservationException e) {
			urlImage = errorImageUrl;
			e.printStackTrace();
		}

		request.setAttribute("prefsURL", urlImage);

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

		include(viewJSP, request, response);
	}

	/*
	 * 
	 * AJAX CALLS
	 */
	@Override
	public void serveResource(ResourceRequest request, ResourceResponse response)
			throws PortletException, IOException {

		final PortletPreferences prefs = request.getPreferences();
		final JSONObject jsonObject = JSONFactoryUtil.createJSONObject();
		String mode = ParamUtil.get(request, "control", "null");

		log.info("Executing operation load_s_image in reservation:"
				+ reservationId);
		try {
			User currentUser = UserLocalServiceUtil.getUserById(Long
					.parseLong(request.getRemoteUser()));
			if (mode.equals("operation")) {
				if (urlImage == null || urlImage.equals(errorImageUrl)) {
					try {
						log.info("Operation Parameter:" + operation_parameter);
						String urlImageParameter = (String) experiment
								.getParameterValue(operation_parameter,
										currentUser.getEmailAddress(),
										currentUser.getPassword(), reservationId);
						if (urlImageParameter != null) {
							urlImage = urlImageParameter;
							jsonObject.put("error", "false");
							log.info("URL of surveillance camera loaded:"
									+ urlImage);
						} else {
							urlImage = errorImageUrl;
							jsonObject.put("error", "true");
							log.error("URL of surveillance camera not detected:"
									+ urlImage);
						}

					} catch (ConnectionException e) {
						urlImage = errorImageUrl;
						jsonObject.put("error", "true");
					} catch (ExperimentOperationException e) {
						urlImage = errorImageUrl;
						jsonObject.put("error", "true");
					} catch (NoSuchOperationException e) {
						urlImage = errorImageUrl;
						jsonObject.put("error", "true");
					} catch (ExperimentParameterException e) {
						urlImage = errorImageUrl;
						jsonObject.put("error", "true");
					} catch (ExperimentNotInstantiatedException e) {
						urlImage = errorImageUrl;
						jsonObject.put("error", "true");
					} catch (OnlineExperimentException e) {
						urlImage = errorImageUrl;
						jsonObject.put("error", "true");
					} catch (NoSuchReservationException e) {
						urlImage = errorImageUrl;
						jsonObject.put("error", "true");
					} catch (NoSuchExperimentException e) {
						urlImage = errorImageUrl;
						jsonObject.put("error", "true");
					}

				} else {
					jsonObject.put("error", "false");
				}
				jsonObject.put("url", urlImage);

			}
		} catch (NumberFormatException e) {
			jsonObject.put("error", "error");
			log.error("Wrong user identificator:" + e.getMessage());
		} catch (PortalException e) {
			jsonObject.put("error", "error");
			log.error("Portal exception:" + e.getMessage());
		} catch (SystemException e) {
			log.error("Portal exception:" + e.getMessage());
			jsonObject.put("error", "error");
		}
		PrintWriter writer = response.getWriter();
		writer.write(jsonObject.toString());
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
