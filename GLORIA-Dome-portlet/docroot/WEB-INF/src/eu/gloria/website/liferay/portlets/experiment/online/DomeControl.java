package eu.gloria.website.liferay.portlets.experiment.online;

import java.io.IOException;

import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Hashtable;
import java.util.List;
import java.util.ResourceBundle;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.TimeUnit;

import javax.portlet.ActionRequest;
import javax.portlet.ActionResponse;
import javax.portlet.PortletException;
import javax.portlet.PortletPreferences;
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

public class DomeControl extends MVCPortlet {

	protected String editJSP;
	protected String viewJSP;
	protected String errorJSP;

	private Integer timeSec = 10;
	private Integer reservationId = -1;

	private ExperimentHandler experiment = null;

	private static Log log = LogFactory.getLog(DomeControl.class);
	private static ResourceBundle rb = ResourceBundle
			.getBundle("content.dome.Language");

	private Hashtable<String, String> operations = null;

	private static String OPEN_DOME = "domeOpen";
	private static String CLOSE_DOME = "domeClose";

	public void init() throws PortletException {
		editJSP = getInitParameter("edit-jsp");
		viewJSP = getInitParameter("view-jsp");
		errorJSP = getInitParameter("error-jsp");

		operations = new Hashtable<String, String>();

		super.init();
	}

	public void processAction(ActionRequest actionRequest,
			ActionResponse actionResponse) throws PortletException, IOException {
		// _log.info("EXECUTNG processAction");

		super.processAction(actionRequest, actionResponse);
	}

	@ProcessAction(name = "saveSettings")
	public void saveSettings(ActionRequest request, ActionResponse response)
			throws PortletException, IOException {
		// _log.info("");
		// _log.info("***saveSettings****");

		PortletPreferences prefs = request.getPreferences();

		String showImagePanel = (String) request
				.getParameter("checkboxImagePanel");
		if (Validator.isNull(showImagePanel))
			showImagePanel = "0";
		else
			showImagePanel = "1";

		String showControlPanel = (String) request
				.getParameter("checkboxControlPanel");
		if (Validator.isNull(showControlPanel))
			showControlPanel = "0";
		else
			showControlPanel = "1";

		String showOpenButton = (String) request
				.getParameter("checkboxOpenButton");
		if (Validator.isNull(showOpenButton))
			showOpenButton = "0";
		else
			showOpenButton = "1";

		String showCloseButton = (String) request
				.getParameter("checkboxCloseButton");
		if (Validator.isNull(showCloseButton))
			showCloseButton = "0";
		else
			showCloseButton = "1";

		if (showControlPanel.equals("0")) {
			showOpenButton = "0";
			showCloseButton = "0";
		}
		if (showOpenButton.equals("0") && showCloseButton.equals("0")) {
			showControlPanel = "0";
		}

		String reservationIdValue = (String) request
				.getParameter("reservationId");

		try {

			prefs.setValue("showControlPanel", showControlPanel);
			prefs.setValue("showImagePanel", showImagePanel);
			prefs.setValue("showOpenButton", showOpenButton);
			prefs.setValue("showCloseButton", showCloseButton);

			prefs.setValue("configured", "true");

			prefs.setValue("reservationId", reservationIdValue);

			prefs.store();

			SessionMessages.add(request, "success");

		} catch (Exception e) {
			SessionErrors.add(request, "not-save");
			prefs.setValue("configured", "false");
		}
		prefs.store();

	}

	public void doView(RenderRequest request, RenderResponse response)
			throws PortletException, IOException {
		// _log.info("");
		// _log.info("***EXECUTNG doView****");

		ThemeDisplay themeDisplay = (ThemeDisplay) request
				.getAttribute(WebKeys.THEME_DISPLAY);
		PortletDisplay portletDisplay = themeDisplay.getPortletDisplay();
		String portletId = portletDisplay.getId();
		PortletPreferences prefs = request.getPreferences();

		/* CONFIGURATION */
		String prefsConfig = (String) prefs.getValue("configured", "false");
		request.setAttribute("configured", prefsConfig);
		// request.setAttribute("configured", "true");

		/* SHOWS */
		String prefsShowControlPanel = (String) prefs.getValue(
				"showControlPanel", "0");
		request.setAttribute("showControlPanel", prefsShowControlPanel);

		String prefsShowImagePanel = (String) prefs.getValue("showImagePanel",
				"0");
		request.setAttribute("showImagePanel", prefsShowImagePanel);

		String prefsShowOpenButton = (String) prefs.getValue("showOpenButton",
				"0");
		request.setAttribute("showOpenButton", prefsShowOpenButton);

		String prefsShowCloseButton = (String) prefs.getValue(
				"showCloseButton", "0");
		request.setAttribute("showCloseButton", prefsShowCloseButton);

		reservationId = Integer.parseInt((String) prefs.getValue(
				"reservationId", "-1"));

		log.info("Rendering dome portlet with reservation:" + reservationId);

		// Portlet configuration

		User currentUser;

		try {
			currentUser = UserLocalServiceUtil.getUserById(Long
					.parseLong(request.getRemoteUser()));

			experiment = new ExperimentHandler();

			// Read operations
			log.info("Mapping available operations");

			// Operation to open dome

			String operation = "open_dome00";
			log.info("Operation detected:" + operation);
			operations.put(OPEN_DOME, operation);

			// Operation to close dome

			operation = "close_dome00";
			log.info("Operation detected:" + operation);
			operations.put(CLOSE_DOME, operation);

			include(viewJSP, request, response);
		} catch (NumberFormatException e) {
			include(errorJSP, request, response);
			e.printStackTrace();
		} catch (PortalException e) {
			include(errorJSP, request, response);
			e.printStackTrace();
		} catch (SystemException e) {
			include(errorJSP, request, response);
			e.printStackTrace();
		}

	}

	public void doEdit(RenderRequest request, RenderResponse response)
			throws PortletException, IOException {
		// _log.info("");
		// _log.info("***EXECUTNG doEdit****");

		PortletPreferences prefs = request.getPreferences();

		String prefsShowControlPanel = (String) prefs.getValue(
				"showControlPanel", "0");
		request.setAttribute("showControlPanel", prefsShowControlPanel);

		String prefsShowImagePanel = (String) prefs.getValue("showImagePanel",
				"0");
		request.setAttribute("showImagePanel", prefsShowImagePanel);

		String prefsShowOpenButton = (String) prefs.getValue("showOpenButton",
				"0");
		request.setAttribute("showOpenButton", prefsShowOpenButton);

		String prefsShowCloseButton = (String) prefs.getValue(
				"showCloseButton", "0");
		request.setAttribute("showCloseButton", prefsShowCloseButton);

		String reservationIdValue = (String) prefs.getValue("reservationId",
				"-1");
		request.setAttribute("reservationId", reservationIdValue);

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

		PortletPreferences prefs = request.getPreferences();
		String telescope = (String) prefs.getValue("telescope",
				rb.getString("label-none"));
		String dome = (String) prefs.getValue("dome",
				rb.getString("label-none"));

		final JSONObject jsonObject = JSONFactoryUtil.createJSONObject();

		String mode = ParamUtil.get(request, "control",
				rb.getString("label-none"));
		// _log.info("mode= "+mode);

		/*
		 * OPERATION
		 */
		if (mode.equals("operation")) {
			String action = ParamUtil.get(request, "action",
					rb.getString("label-none"));
			try {

				User currentUser = UserLocalServiceUtil.getUserById(Long
						.parseLong(request.getRemoteUser()));

				if (action.equalsIgnoreCase("open")) {

					experiment.executeOperation(operations.get(OPEN_DOME),
							currentUser.getEmailAddress(),
							currentUser.getPassword(), reservationId);

				} else if (action.equalsIgnoreCase("close")) {
					experiment.executeOperation(operations.get(CLOSE_DOME),
							currentUser.getEmailAddress(),
							currentUser.getPassword(), reservationId);
				}
				jsonObject.put("success", true);

			} catch (ConnectionException e) {
				jsonObject.put("success", false);
				jsonObject.put("message", "error_operation");
				log.error("Wrong user identificator:" + e.getMessage());
			} catch (ExperimentOperationException e) {
				jsonObject.put("success", false);
				jsonObject.put("message", "error_operation");
				log.error("Wrong logic in experiment:" + e.getMessage());
			} catch (NoSuchOperationException e) {
				jsonObject.put("success", false);
				jsonObject.put("message", "error_operation");
				log.error("Operation not valid:" + e.getMessage());
			} catch (ExperimentParameterException e) {
				jsonObject.put("success", false);
				jsonObject.put("message", "error_operation");
				log.error("Error to write/read parameter:" + e.getMessage());
			} catch (ExperimentNotInstantiatedException e) {
				jsonObject.put("success", false);
				jsonObject.put("message", "error_reservation_not_active");
				log.error("Imposible to create experiment context:"
						+ e.getMessage());
			} catch (OnlineExperimentException e) {
				jsonObject.put("success", false);
				jsonObject.put("message", "error_operation");
				log.error("System error:" + e.getMessage());
			} catch (NoSuchReservationException e) {
				jsonObject.put("success", false);
				jsonObject.put("message", "error_reservation_not_active");
				log.error("Reservation not active:" + e.getMessage());
			} catch (NoSuchExperimentException e) {
				jsonObject.put("success", false);
				jsonObject.put("message", "error_reservation_not_active");
				log.error("Experiment not valid:" + e.getMessage());
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

		} // end-if-operation

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
