package eu.gloria.website.liferay.portlets.experiment.online;

import com.liferay.util.bridges.mvc.MVCPortlet;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Hashtable;
import java.util.List;
import java.util.Properties;
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
import javax.portlet.RenderMode;
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
import com.liferay.portal.kernel.util.Validator;
import com.liferay.portal.model.User;
import com.liferay.portal.service.UserLocalServiceUtil;
import com.liferay.util.bridges.mvc.MVCPortlet;

import eu.gloria.gs.services.experiment.online.OnlineExperimentException;
import eu.gloria.gs.services.experiment.online.data.NoSuchExperimentException;
import eu.gloria.gs.services.experiment.online.models.InvalidExperimentModelException;
import eu.gloria.gs.services.experiment.online.operations.ExperimentOperationException;
import eu.gloria.gs.services.experiment.online.operations.NoSuchOperationException;
import eu.gloria.gs.services.experiment.online.parameters.ExperimentParameterException;
import eu.gloria.gs.services.experiment.online.parameters.UndefinedExperimentParameterException;
import eu.gloria.gs.services.experiment.online.reservation.ExperimentNotInstantiatedException;
import eu.gloria.gs.services.experiment.online.reservation.ExperimentReservationArgumentException;
import eu.gloria.gs.services.experiment.online.reservation.NoSuchReservationException;
import eu.gloria.presentation.liferay.services.ExperimentHandler;
import eu.gloria.presentation.liferay.services.exception.ConnectionException;

public class MountControl extends MVCPortlet {

	protected String editJSP;
	protected String viewJSP;
	protected String errorJSP;
	
	//Operations
	private static String MOVE_UP = "moveUp";
	private static String MOVE_DOWN = "moveDown";
	private static String MOVE_LEFT = "moveLeft";
	private static String MOVE_RIGHT = "moveRight";
	private static String MOVE_SUN = "moveSun";
	
	//Parameters
	private static String MAX_MOVEMENTS = "maxMovements";
	private static String CURRENTX = "currentX";
	private static String CURRENTY = "currentY";
	
	private static Log log = LogFactory.getLog(MountControl.class);
	private static ResourceBundle rb = ResourceBundle
			.getBundle("content.mount.Language");

	private int reservationId = -1;
	
	private int remainingRight = -1;
	private int remainingLeft = -1;
	private int remainingUp = -1;
	private int remainingDown = -1;
	
	
	private ExperimentHandler experiment = null;

	private Integer timeSec = 10;
	
	private Hashtable<String, String> operations = null;
	private Hashtable<String, String> parameters = null;
	
	public void init() throws PortletException {
		editJSP = getInitParameter("edit-jsp");
		viewJSP = getInitParameter("view-jsp");
		errorJSP = getInitParameter("error-jsp");
		
		operations = new Hashtable<String, String>();
		parameters = new Hashtable<String, String>();

		super.init();
	}

	public void processAction(ActionRequest actionRequest,
			ActionResponse actionResponse) throws PortletException, IOException {

		super.processAction(actionRequest, actionResponse);
	}

	@ProcessAction(name = "settingsForm")
	public void settingsForm(ActionRequest request, ActionResponse response)
			throws PortletException, IOException {

		PortletPreferences prefs = request.getPreferences();
		
		String reservationIdValue = (String) request
				.getParameter("reservationId");
		
		String showSpeedPanel = (String) request
				.getParameter("checkboxSpeedPanel");
		
		if (Validator.isNull(showSpeedPanel))
			showSpeedPanel = "0";
		else
			showSpeedPanel = "1";

		String showPointerPanel = (String) request
				.getParameter("checkboxPointerPanel");
		if (Validator.isNull(showPointerPanel))
			showPointerPanel = "0";
		else
			showPointerPanel = "1";

		String showRaDecPanel = (String) request
				.getParameter("checkboxRaDecPanel");
		if (Validator.isNull(showRaDecPanel))
			showRaDecPanel = "0";
		else
			showRaDecPanel = "1";

		String showEpochPanel = (String) request
				.getParameter("checkboxEpochPanel");
		if (Validator.isNull(showEpochPanel))
			showEpochPanel = "0";
		else
			showEpochPanel = "1";

		String showObjectPanel = (String) request
				.getParameter("checkboxObjectPanel");
		if (Validator.isNull(showObjectPanel))
			showObjectPanel = "0";
		else
			showObjectPanel = "1";

		String showModePanel = (String) request
				.getParameter("checkboxModePanel");
		if (Validator.isNull(showModePanel))
			showModePanel = "0";
		else
			showModePanel = "1";

		String showInfoPanel = (String) request
				.getParameter("checkboxInformationPanel");
		if (Validator.isNull(showInfoPanel))
			showInfoPanel = "0";
		else
			showInfoPanel = "1";

		try {

			prefs.setValue("showSpeedPanel", showSpeedPanel);
			prefs.setValue("showPointerPanel", showPointerPanel);
			prefs.setValue("showRaDecPanel", showRaDecPanel);
			prefs.setValue("showEpochPanel", showEpochPanel);
			prefs.setValue("showInfoPanel", showInfoPanel);
			prefs.setValue("showObjectPanel", showObjectPanel);
			prefs.setValue("showModePanel", showModePanel);

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

		PortletPreferences prefs = request.getPreferences();

		String prefsConfig = (String) prefs.getValue("configured", "false");
		request.setAttribute("configured", prefsConfig);

		String prefsShowSpeedPanel = (String) prefs.getValue("showSpeedPanel",
				"0");
		request.setAttribute("showSpeedPanel", prefsShowSpeedPanel);

		String prefsShowPointerPanel = (String) prefs.getValue(
				"showPointerPanel", "0");
		request.setAttribute("showPointerPanel", prefsShowPointerPanel);

		String prefsShowRaDecPanel = (String) prefs.getValue("showRaDecPanel",
				"0");
		request.setAttribute("showRaDecPanel", prefsShowRaDecPanel);

		String prefsShowEpochPanel = (String) prefs.getValue("showEpochPanel",
				"0");
		request.setAttribute("showEpochPanel", prefsShowEpochPanel);

		String prefsShowObjectPanel = (String) prefs.getValue(
				"showObjectPanel", "0");
		request.setAttribute("showObjectPanel", prefsShowObjectPanel);

		String prefsShowModePanel = (String) prefs.getValue("showModePanel",
				"0");
		request.setAttribute("showModePanel", prefsShowModePanel);

		String prefsShowInfoPanel = (String) prefs.getValue("showInfoPanel",
				"0");
		request.setAttribute("showInfoPanel", prefsShowInfoPanel);

		String prefsMode = (String) prefs.getValue("mode",
				rb.getString("label-none"));
		request.setAttribute("prefsMode", prefsMode);

		String prefsObject = (String) prefs.getValue("object",
				rb.getString("label-none"));
		request.setAttribute("prefsObject", prefsObject);

		String prefsEpoch = (String) prefs.getValue("epoch", "J2000");
		request.setAttribute("prefsEpoch", prefsEpoch);
		
		String reservationIdValue = (String) prefs.getValue("reservationId", "-1");
		request.setAttribute("reservationId", reservationIdValue);
				

		reservationId = Integer.parseInt((String) prefs.getValue(
				"reservationId", "-1"));
		
		log.info("Reservation:"+reservationId);
		
		operations = new Hashtable<String, String>();
		parameters = new Hashtable<String, String>();

			User currentUser;
			try {
				currentUser = UserLocalServiceUtil.getUserById(Long.parseLong(request.getRemoteUser()));
					
				experiment = new ExperimentHandler();
				
				//Read operations
				log.info("Mapping available operations");
				
				
				//Operation to move up
			
				String operation = "move_up00";			
				log.info("Operation detected:"+operation);
				operations.put(MOVE_UP, operation);
				
				//Operation to move down
				
				operation = "move_down00";
				log.info("Operation detected:"+operation);
				operations.put(MOVE_DOWN, operation);
				
				//Operation to move left
				operation = "move_left00"; 			
				log.info("Operation detected:"+operation);
				operations.put(MOVE_LEFT, operation);
				
				//Operation to move right
				operation = "move_right00";			
				log.info("Operation detected:"+operation);
				operations.put(MOVE_RIGHT, operation);
				
				//Operation to move sun
				
				operation = "goto_object";	
				log.info("Operation detected:"+operation);
				operations.put(MOVE_SUN, operation);
				
				//Operation to get remaining movements
				parameters.put(MAX_MOVEMENTS, "max_moves00");
				parameters.put(CURRENTX, "current_moves_x00");
				parameters.put(CURRENTY, "current_moves_y00");
				
				int remainingMovements = (Integer) experiment.getParameterValue(parameters.get(MAX_MOVEMENTS),
						currentUser.getEmailAddress(),
						currentUser.getPassword(), reservationId);
				int currentX = (Integer) experiment.getParameterValue(parameters.get(CURRENTX),
						currentUser.getEmailAddress(),
						currentUser.getPassword(), reservationId);
				int currentY = (Integer) experiment.getParameterValue(parameters.get(CURRENTY),
						currentUser.getEmailAddress(),
						currentUser.getPassword(), reservationId);
				log.info("Remaining movements:"+remainingMovements+"-["+currentX+","+currentY+"]");
				
				remainingRight = remainingMovements - currentX;
				remainingLeft = remainingMovements + currentX;
				remainingUp = remainingMovements - currentY;
				remainingDown = remainingMovements + currentY;
				
				request.setAttribute("remainingRight", String.valueOf(remainingRight));
				request.setAttribute("remainingLeft", String.valueOf(remainingLeft));
				request.setAttribute("remainingUp", String.valueOf(remainingUp));
				request.setAttribute("remainingDown", String.valueOf(remainingDown));
				
						
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
			} catch (ConnectionException e) {
				include(errorJSP, request, response);
				e.printStackTrace();
			} catch (ExperimentOperationException e) {
				include(errorJSP, request, response);
				e.printStackTrace();
			} catch (NoSuchOperationException e) {
				include(errorJSP, request, response);
				e.printStackTrace();
			} catch (ExperimentParameterException e) {
				include(errorJSP, request, response);
				e.printStackTrace();
			} catch (ExperimentNotInstantiatedException e) {
				include(errorJSP, request, response);
				e.printStackTrace();
			} catch (OnlineExperimentException e) {
				include(errorJSP, request, response);
				e.printStackTrace();
			} catch (NoSuchReservationException e) {
				include(errorJSP, request, response);
				e.printStackTrace();
			} catch (NoSuchExperimentException e) {
				include(errorJSP, request, response);
				e.printStackTrace();
			}
		
		

		

	}

	public void doEdit(RenderRequest request, RenderResponse response)
			throws PortletException, IOException {
		// _log.info("");
		// _log.info("***EXECUTNG doEdit****");

		PortletPreferences prefs = request.getPreferences();

		String prefsShowSpeedPanel = (String) prefs.getValue("showSpeedPanel",
				"0");
		request.setAttribute("showSpeedPanel", prefsShowSpeedPanel);

		String prefsShowPointerPanel = (String) prefs.getValue(
				"showPointerPanel", "0");
		request.setAttribute("showPointerPanel", prefsShowPointerPanel);

		String prefsShowRaDecPanel = (String) prefs.getValue("showRaDecPanel",
				"0");
		request.setAttribute("showRaDecPanel", prefsShowRaDecPanel);

		String prefsShowEpochPanel = (String) prefs.getValue("showEpochPanel",
				"0");
		request.setAttribute("showEpochPanel", prefsShowEpochPanel);

		String prefsShowObjectPanel = (String) prefs.getValue(
				"showObjectPanel", "0");
		request.setAttribute("showObjectPanel", prefsShowObjectPanel);

		String prefsShowModePanel = (String) prefs.getValue("showModePanel",
				"0");
		request.setAttribute("showModePanel", prefsShowModePanel);

		String prefsShowInfoPanel = (String) prefs.getValue("showInfoPanel",
				"0");
		request.setAttribute("showInfoPanel", prefsShowInfoPanel);
		
		String reservationIdValue = (String) prefs.getValue("reservationId", "-1");
		request.setAttribute("reservationId", reservationIdValue);
		
//		experimentConfigured = false;

		include(editJSP, request, response);
	}

	@RenderMode(name = "showDetails")
	public String showDetails() {
		// _log.info("");
		// _log.info("***EXECUTNG showDetails****");
		return "showDetails";
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


		final JSONObject jsonObject = JSONFactoryUtil.createJSONObject();

		String mode = ParamUtil.get(request, "control",
				rb.getString("label-none"));
		// _log.info("mode= "+mode);
		/*
		 * MOVE
		 */
		try {

			User currentUser = UserLocalServiceUtil.getUserById(Long.parseLong(request.getRemoteUser()));
			if (mode.equals("move")) {
				String move = ParamUtil.get(request, "move",
						rb.getString("label-none"));

				if (move.equalsIgnoreCase("north")) {
					log.info("Move to north");
					experiment.executeOperation(operations.get(MOVE_UP),
							currentUser.getEmailAddress(),
							currentUser.getPassword(), reservationId);
				} else if (move.equalsIgnoreCase("south")) {
					log.info("Move to south");
					experiment.executeOperation(operations.get(MOVE_DOWN),
							currentUser.getEmailAddress(),
							currentUser.getPassword(), reservationId);
					

				} else if (move.equalsIgnoreCase("west")) {
					log.info("Move to west");
					experiment.executeOperation(operations.get(MOVE_LEFT),
							currentUser.getEmailAddress(),
							currentUser.getPassword(), reservationId);
				

				} else if (move.equalsIgnoreCase("east")) {
					log.info("Move to east");
					experiment.executeOperation(operations.get(MOVE_RIGHT),
							currentUser.getEmailAddress(),
							currentUser.getPassword(), reservationId);
					

				}
				jsonObject.put("success", true);
				int remainingMovements = (Integer) experiment.getParameterValue(parameters.get(MAX_MOVEMENTS),
						currentUser.getEmailAddress(),
						currentUser.getPassword(), reservationId);
				int currentX = (Integer) experiment.getParameterValue(parameters.get(CURRENTX),
						currentUser.getEmailAddress(),
						currentUser.getPassword(), reservationId);
				int currentY = (Integer) experiment.getParameterValue(parameters.get(CURRENTY),
						currentUser.getEmailAddress(),
						currentUser.getPassword(), reservationId);
				log.info("Remaining movements:"+remainingMovements+"-["+currentX+","+currentY+"]");
				
							
				jsonObject.put("remainingUp", String.valueOf(remainingMovements - currentY));
				jsonObject.put("remainingDown", String.valueOf(remainingMovements + currentY));
				jsonObject.put("remainingLeft", String.valueOf(remainingMovements + currentX));
				jsonObject.put("remainingRight", String.valueOf(remainingMovements - currentX));
				
			} else if (mode.equals("object")){
				log.info("Moving to SUN ...");
				experiment.executeOperation(operations.get(MOVE_SUN),
						currentUser.getEmailAddress(),
						currentUser.getPassword(), reservationId);
				jsonObject.put("success", true);
				
				int remainingMovements = (Integer) experiment.getParameterValue(parameters.get(MAX_MOVEMENTS),
						currentUser.getEmailAddress(),
						currentUser.getPassword(), reservationId);
				int currentX = (Integer) experiment.getParameterValue(parameters.get(CURRENTX),
						currentUser.getEmailAddress(),
						currentUser.getPassword(), reservationId);
				int currentY = (Integer) experiment.getParameterValue(parameters.get(CURRENTY),
						currentUser.getEmailAddress(),
						currentUser.getPassword(), reservationId);
				log.info("Remaining movements:"+remainingMovements+"-["+currentX+","+currentY+"]");
				
							
				jsonObject.put("remainingUp", String.valueOf(remainingMovements - currentY));
				jsonObject.put("remainingDown", String.valueOf(remainingMovements + currentY));
				jsonObject.put("remainingLeft", String.valueOf(remainingMovements + currentX));
				jsonObject.put("remainingRight", String.valueOf(remainingMovements - currentX));
			}
			

		} catch (NumberFormatException e) {
			jsonObject.put("success", false);
			jsonObject.put("message", "error_operation");
			log.error("Wrong user identificator:" + e.getMessage());
		} catch (OnlineExperimentException e) { //error de ejecución para operación
			jsonObject.put("success", false);
			jsonObject.put("message", "error_execution");
			log.error("Error to execute action:" + e.getMessage());
		} catch (ExperimentOperationException e) { //error de ejecución en la operación
			jsonObject.put("success", false);
			if (e.getMessage().contains("problem")){
				jsonObject.put("message", "error_operation");
			} else if (e.getMessage().contains("limit")){
				jsonObject.put("message", "error_limit");				
			}
			log.error("Failed in operation:"+e.getMessage());
		} catch (ExperimentParameterException e) {
			jsonObject.put("success", false);
			jsonObject.put("message", "error_execution");
			log.error("Problem with parameter:"+e.getMessage()); //error de ejecución
		} catch (ConnectionException e) { //TODO Ask Fernando
			jsonObject.put("success", false);
			jsonObject.put("message", "error_operation");
			log.error("Operation exception:" + e.getMessage());
		} catch (NoSuchOperationException e) {
			jsonObject.put("success", false);
			jsonObject.put("message", "error_operation");
			log.error("Operation exception:" + e.getMessage());
		} catch (ExperimentNotInstantiatedException e) {
			jsonObject.put("success", false);
			jsonObject.put("message", "error_operation");
			log.error("Operation exception:" + e.getMessage());
		} catch (NoSuchReservationException e) {
			jsonObject.put("success", false);
			jsonObject.put("message", "error_operation");
			log.error("Operation exception:" + e.getMessage());
		} catch (NoSuchExperimentException e) {
			jsonObject.put("success", false);
			jsonObject.put("message", "error_operation");
			log.error("Operation exception:" + e.getMessage());
		} catch (PortalException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SystemException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 

		/*
		 * SPEED
		 */
		// if (mode.equals("speed")) {
		// String speed = ParamUtil.get(request, "speed",
		// rb.getString("label-none"));
		// try {
		// mntServ.setSpeed (telescope, mount, speed);
		// } catch (Exception e) {
		// jsonObject.put("error", "error");
		// }
		// }

		/*
		 * SET COORDINATES
		 */
		// if (mode.equals("setCoordinates")) {
		// String prefEpoch = (String) prefs.getValue("epoch", "J2000");
		// String prefMode = (String) prefs.getValue("mode",
		// rb.getString("label-none"));
		//
		// try {
		// String ra = ParamUtil.get(request, "ra",
		// rb.getString("label-default-ra-coordinates"));
		// String dec = ParamUtil.get(request, "dec",
		// rb.getString("label-default-dec-coordinates"));
		// String epoch = ParamUtil.get(request, "epoch", "J2000");
		// String modeMount = ParamUtil.get(request, "mode",
		// rb.getString("label-none"));
		//
		// mntServ.setCoordinates(telescope, mount,ra,dec);
		//
		// if (!prefEpoch.equalsIgnoreCase(epoch)) {
		// mntServ.setEpoch(telescope, mount, epoch);
		// prefs.setValue("epoch", epoch);
		// }
		//
		// if (!prefMode.equalsIgnoreCase(modeMount)) {
		// mntServ.setMode(telescope, mount, modeMount);
		// prefs.setValue("mode", modeMount);
		// }
		// prefs.store();
		//
		// } catch (Exception e) {
		// jsonObject.put("error", "error");
		// }
		// }

		/*
		 * GET COORDINATES
		 */
		// if (mode.equals("getCoordinates")) {
		// try {
		// jsonObject.put("ra", mntServ.getRa(telescope, mount));
		// jsonObject.put("dec", mntServ.getDec(telescope, mount));
		// jsonObject.put("az", mntServ.getAz(telescope, mount));
		// jsonObject.put("alt", mntServ.getAlt(telescope, mount));
		// } catch (Exception e) {
		// jsonObject.put("error", "error");
		// }
		// }

		/*
		 * OBJECT
		 */
		// if (mode.equals("object")) {
		// String obj = ParamUtil.get(request, "object",
		// rb.getString("label-none"));
		// try {
		// mntServ.setTargetObject(telescope, mount, obj);
		// prefs.setValue("object", obj);
		// prefs.store();
		//
		// } catch (Exception e) {
		// jsonObject.put("error", "error");
		// }
		// }

		/*
		 * PARK
		 */
		// if (mode.equals("park")) {
		// try {
		// mntServ.setPark(telescope, mount);
		// } catch (Exception e) {
		// jsonObject.put("error", "error");
		// }
		// }

		/*
		 * EDIT MODE
		 */
		// if (mode.equals("edit")) {
		// final String observatory = ParamUtil.get(request, "observatory",
		// rb.getString("label-none"));
		// final String editTelescope = ParamUtil.get(request, "telescope",
		// rb.getString("label-none"));
		// final String editMount = ParamUtil.get(request, "mount",
		// rb.getString("label-none"));
		//
		// // _log.info("observatory= "+observatory);
		// // _log.info("telescope= "+editTelescope);
		// // _log.info("mount= "+editMount);
		//
		// ExecutorService exec = Executors.newFixedThreadPool(1);
		// exec.execute(new Runnable() {
		// public void run() {
		// if (!observatory.equalsIgnoreCase(rb.getString("label-none")) &&
		// editTelescope.equalsIgnoreCase(rb.getString("label-none"))) {
		// try{
		// List<String> strList = devObject.getTelescopesList(observatory);
		// jsonObject.put("telsList", strList.toString());
		// } catch (Exception e){
		// _log.error(e.getMessage());
		// }
		// }
		// if (!editTelescope.equalsIgnoreCase(rb.getString("label-none")) &&
		// editMount.equalsIgnoreCase(rb.getString("label-none"))) {
		// try{
		// List<String> strList = devObject.getMountList(editTelescope);
		// jsonObject.put("mountsList", strList.toString());
		// } catch (Exception e){
		// _log.error(e.getMessage());
		// }
		// }
		//
		// if (!editMount.equalsIgnoreCase(rb.getString("label-none"))) {
		// }
		// } // end-run
		// }); // end-exec
		//
		// exec.shutdown();
		//
		// try {
		// boolean b = exec.awaitTermination(timeSec, TimeUnit.SECONDS);
		// if (!b) {
		// _log.error("Timer has expired");
		// exec.shutdown();
		// }
		// } catch (InterruptedException e) {
		// _log.info(e.getMessage());
		// } // end-try
		//
		// }

		// Enumeration param = request.getParameterNames();
		// while (param.hasMoreElements()) {
		// String name = (String) param.nextElement();
		// _log.info(name +"=\""+ request.getParameter(name)+"\"");
		// }

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
