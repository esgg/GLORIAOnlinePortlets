package eu.gloria.website.liferay.portlets.experiment.online;

import java.io.IOException;

import java.io.PrintWriter;
import java.util.HashMap;
import java.util.ResourceBundle;

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

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.liferay.portal.kernel.exception.PortalException;
import com.liferay.portal.kernel.exception.SystemException;
import com.liferay.portal.kernel.json.JSONFactoryUtil;
import com.liferay.portal.kernel.json.JSONObject;
import com.liferay.portal.kernel.servlet.SessionErrors;
import com.liferay.portal.kernel.servlet.SessionMessages;
import com.liferay.portal.kernel.util.ParamUtil;
import com.liferay.portal.model.User;
import com.liferay.portal.service.UserLocalServiceUtil;
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

public class FocuserControl extends MVCPortlet {

	protected String editJSP;
	protected String viewJSP;
	protected String errorJSP;

	private static Log log = LogFactory.getLog(FocuserControl.class);
	private static ResourceBundle rb = ResourceBundle
			.getBundle("content.focuser.Language");
	
	private static int STEPS = 150;

	private int reservationId = -1;

	private ExperimentHandler experiment = null;

	private String moveFocus = null;
	private String numStepsParam = "focus_steps"; // TODO ask for its

	public void init() throws PortletException {
		editJSP = getInitParameter("edit-jsp");
		viewJSP = getInitParameter("view-jsp");
		errorJSP = getInitParameter("error-jsp");

		super.init();
	}

	public void doView(RenderRequest request, RenderResponse response)
			throws PortletException, IOException {

		PortletPreferences prefs = request.getPreferences();

		reservationId = Integer.parseInt((String) prefs.getValue(
				"reservationId", "-1"));

		experiment = new ExperimentHandler();

		moveFocus = "move_focus";

		log.info("Move focuser operation detected:" + moveFocus);

		include(viewJSP, request, response);

	}

	@ProcessAction(name = "settingsForm")
	public void settingsForm(ActionRequest request, ActionResponse response)
			throws PortletException, IOException {

		PortletPreferences prefs = request.getPreferences();

		String reservationIdValue = (String) request
				.getParameter("reservationId");

		try {
			prefs.setValue("reservationId", reservationIdValue);

			SessionMessages.add(request, "success");
		} catch (Exception e) {
			SessionErrors.add(request, "not-save");
		}
		prefs.store();
	}

	public void serveResource(ResourceRequest request, ResourceResponse response)
			throws PortletException, IOException {

		boolean hasSuccess = false;
		String message = rb.getString("label-not-defined");

		final JSONObject jsonObject = JSONFactoryUtil.createJSONObject();

		String operation = ParamUtil.get(request, "operation",
				rb.getString("label-none"));

		try {

			User currentUser = UserLocalServiceUtil.getUserById(Long
					.parseLong(request.getRemoteUser()));

			if (operation.equals("move")) {
				String direction = ParamUtil.get(request, "direction",
						rb.getString("label-none"));
				log.info("Move " + direction + " focuser");
				if (direction.equals("out")) {
					experiment.setParameterValue(numStepsParam,
							STEPS,
							currentUser.getEmailAddress(),
							currentUser.getPassword(), reservationId);
				} else if (direction.equals("in")) {
					experiment.setParameterValue(numStepsParam,
							STEPS * (-1),
							currentUser.getEmailAddress(),
							currentUser.getPassword(), reservationId);
				}

				experiment.executeOperation(moveFocus,
						currentUser.getEmailAddress(),
						currentUser.getPassword(), reservationId);
			}
			hasSuccess = true;
			message = rb.getString("label-status-moved");
		} catch (NumberFormatException e) {
			hasSuccess = false;
			message = rb.getString("error_operation");
			log.error("Wrong user identificator:" + e.getMessage());
		} catch (OnlineExperimentException e) { //error de ejecución para operación
			hasSuccess = false;
			message = rb.getString("error_execution");
			log.error("Error to execute action:" + e.getMessage());
		} catch (ExperimentOperationException e) { //error de ejecución en la operación
			hasSuccess = false;
			message = rb.getString("error_operation");
			log.error("Failed in operation:"+e.getMessage());
		} catch (ExperimentParameterException e) {
			hasSuccess = false;
			message = rb.getString("error_execution");
			log.error("Problem with parameter:"+e.getMessage()); //error de ejecución
		} catch (ConnectionException e) { //TODO Ask Fernando
			hasSuccess = false;
			message = rb.getString("error_operation");
			log.error("Operation exception:" + e.getMessage());
		} catch (NoSuchOperationException e) {
			hasSuccess = false;
			message = rb.getString("error_operation");
			log.error("Operation exception:" + e.getMessage());
		} catch (ExperimentNotInstantiatedException e) {
			hasSuccess = false;
			message = rb.getString("error_operation");
			log.error("Operation exception:" + e.getMessage());
		} catch (NoSuchReservationException e) {
			hasSuccess = false;
			message = rb.getString("error_operation");
			log.error("Operation exception:" + e.getMessage());
		} catch (NoSuchExperimentException e) {
			hasSuccess = false;
			message = rb.getString("error_operation");
			log.error("Operation exception:" + e.getMessage());
		} catch (PortalException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SystemException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 

		jsonObject.put("success", hasSuccess);
		jsonObject.put("message", message);

		PrintWriter writer = response.getWriter();
		writer.write(jsonObject.toString());

	}

	public void doEdit(RenderRequest request, RenderResponse response)
			throws PortletException, IOException {

		PortletPreferences prefs = request.getPreferences();

		String reservationIdValue = (String) prefs.getValue("reservationId",
				"-1");
		request.setAttribute("reservationId", reservationIdValue);

		include(editJSP, request, response);

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
