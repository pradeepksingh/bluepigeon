	<%@page import="org.bluepigeon.admin.model.AdminUser"%>
<% 
                        
                        session = request.getSession(false);
						int loggedin_id = 0;
                        AdminUser leftNav = new AdminUser();
                        if(session!=null)
                        {
                        	System.out.print("session is not null..");
                        	if(session.getAttribute("uname") != null)
                        	{
                        		System.out.print("session attribute is not null..");
                        		leftNav  = (AdminUser)session.getAttribute("uname");
                        		loggedin_id = leftNav.getAdminUserRole().getId();
                        		//out.print(leftNav.getName());
                        	}
                        }
                        
                        %>
	<body class="no-skin">
		<div id="navbar" class="navbar navbar-default          ace-save-state">
			<div class="navbar-container ace-save-state" id="navbar-container">
				<button type="button" class="navbar-toggle menu-toggler pull-left" id="menu-toggler" data-target="#sidebar">
					<span class="sr-only">Toggle sidebar</span>

					<span class="icon-bar"></span>

					<span class="icon-bar"></span>

					<span class="icon-bar"></span>
				</button>

				<div class="navbar-header pull-left">
					<a href="${baseUrl}/" class="navbar-brand">
						<small>
							<i class="fa fa-leaf"></i>
							Blue Pigeon Admin
						</small>
					</a>
				</div>

				<div class="navbar-buttons navbar-header pull-right" role="navigation">
					<ul class="nav ace-nav">
<!-- 						<li class="grey dropdown-modal"> -->
<!-- 							<a data-toggle="dropdown" class="dropdown-toggle" href="#"> -->
<!-- 								<i class="ace-icon fa fa-tasks"></i> -->
<!-- 								<span class="badge badge-grey">4</span> -->
<!-- 							</a> -->

<!-- 							<ul class="dropdown-menu-right dropdown-navbar dropdown-menu dropdown-caret dropdown-close"> -->
<!-- 								<li class="dropdown-header"> -->
<!-- 									<i class="ace-icon fa fa-check"></i> -->
<!-- 									4 Tasks to complete -->
<!-- 								</li> -->

<!-- 								<li class="dropdown-content"> -->
<!-- 									<ul class="dropdown-menu dropdown-navbar"> -->
<!-- 										<li> -->
<!-- 											<a href="#"> -->
<!-- 												<div class="clearfix"> -->
<!-- 													<span class="pull-left">Software Update</span> -->
<!-- 													<span class="pull-right">65%</span> -->
<!-- 												</div> -->

<!-- 												<div class="progress progress-mini"> -->
<!-- 													<div style="width:65%" class="progress-bar"></div> -->
<!-- 												</div> -->
<!-- 											</a> -->
<!-- 										</li> -->

<!-- 										<li> -->
<!-- 											<a href="#"> -->
<!-- 												<div class="clearfix"> -->
<!-- 													<span class="pull-left">Hardware Upgrade</span> -->
<!-- 													<span class="pull-right">35%</span> -->
<!-- 												</div> -->

<!-- 												<div class="progress progress-mini"> -->
<!-- 													<div style="width:35%" class="progress-bar progress-bar-danger"></div> -->
<!-- 												</div> -->
<!-- 											</a> -->
<!-- 										</li> -->

<!-- 										<li> -->
<!-- 											<a href="#"> -->
<!-- 												<div class="clearfix"> -->
<!-- 													<span class="pull-left">Unit Testing</span> -->
<!-- 													<span class="pull-right">15%</span> -->
<!-- 												</div> -->

<!-- 												<div class="progress progress-mini"> -->
<!-- 													<div style="width:15%" class="progress-bar progress-bar-warning"></div> -->
<!-- 												</div> -->
<!-- 											</a> -->
<!-- 										</li> -->

<!-- 										<li> -->
<!-- 											<a href="#"> -->
<!-- 												<div class="clearfix"> -->
<!-- 													<span class="pull-left">Bug Fixes</span> -->
<!-- 													<span class="pull-right">90%</span> -->
<!-- 												</div> -->

<!-- 												<div class="progress progress-mini progress-striped active"> -->
<!-- 													<div style="width:90%" class="progress-bar progress-bar-success"></div> -->
<!-- 												</div> -->
<!-- 											</a> -->
<!-- 										</li> -->
<!-- 									</ul> -->
<!-- 								</li> -->

<!-- 								<li class="dropdown-footer"> -->
<!-- 									<a href="#"> -->
<!-- 										See tasks with details -->
<!-- 										<i class="ace-icon fa fa-arrow-right"></i> -->
<!-- 									</a> -->
<!-- 								</li> -->
<!-- 							</ul> -->
<!-- 						</li> -->

<!-- 						<li class="purple dropdown-modal"> -->
<!-- 							<a data-toggle="dropdown" class="dropdown-toggle" href="#"> -->
<!-- 								<i class="ace-icon fa fa-bell icon-animated-bell"></i> -->
<!-- 								<span class="badge badge-important">8</span> -->
<!-- 							</a> -->

<!-- 							<ul class="dropdown-menu-right dropdown-navbar navbar-pink dropdown-menu dropdown-caret dropdown-close"> -->
<!-- 								<li class="dropdown-header"> -->
<!-- 									<i class="ace-icon fa fa-exclamation-triangle"></i> -->
<!-- 									8 Notifications -->
<!-- 								</li> -->

<!-- 								<li class="dropdown-content"> -->
<!-- 									<ul class="dropdown-menu dropdown-navbar navbar-pink"> -->
<!-- 										<li> -->
<!-- 											<a href="#"> -->
<!-- 												<div class="clearfix"> -->
<!-- 													<span class="pull-left"> -->
<!-- 														<i class="btn btn-xs no-hover btn-pink fa fa-comment"></i> -->
<!-- 														New Comments -->
<!-- 													</span> -->
<!-- 													<span class="pull-right badge badge-info">+12</span> -->
<!-- 												</div> -->
<!-- 											</a> -->
<!-- 										</li> -->

<!-- 										<li> -->
<!-- 											<a href="#"> -->
<!-- 												<i class="btn btn-xs btn-primary fa fa-user"></i> -->
<!-- 												Bob just signed up as an editor ... -->
<!-- 											</a> -->
<!-- 										</li> -->

<!-- 										<li> -->
<!-- 											<a href="#"> -->
<!-- 												<div class="clearfix"> -->
<!-- 													<span class="pull-left"> -->
<!-- 														<i class="btn btn-xs no-hover btn-success fa fa-shopping-cart"></i> -->
<!-- 														New Orders -->
<!-- 													</span> -->
<!-- 													<span class="pull-right badge badge-success">+8</span> -->
<!-- 												</div> -->
<!-- 											</a> -->
<!-- 										</li> -->

<!-- 										<li> -->
<!-- 											<a href="#"> -->
<!-- 												<div class="clearfix"> -->
<!-- 													<span class="pull-left"> -->
<!-- 														<i class="btn btn-xs no-hover btn-info fa fa-twitter"></i> -->
<!-- 														Followers -->
<!-- 													</span> -->
<!-- 													<span class="pull-right badge badge-info">+11</span> -->
<!-- 												</div> -->
<!-- 											</a> -->
<!-- 										</li> -->
<!-- 									</ul> -->
<!-- 								</li> -->

<!-- 								<li class="dropdown-footer"> -->
<!-- 									<a href="#"> -->
<!-- 										See all notifications -->
<!-- 										<i class="ace-icon fa fa-arrow-right"></i> -->
<!-- 									</a> -->
<!-- 								</li> -->
<!-- 							</ul> -->
<!-- 						</li> -->

<!-- 						<li class="green dropdown-modal"> -->
<!-- 							<a data-toggle="dropdown" class="dropdown-toggle" href="#"> -->
<!-- 								<i class="ace-icon fa fa-envelope icon-animated-vertical"></i> -->
<!-- 								<span class="badge badge-success">5</span> -->
<!-- 							</a> -->

<!-- 							<ul class="dropdown-menu-right dropdown-navbar dropdown-menu dropdown-caret dropdown-close"> -->
<!-- 								<li class="dropdown-header"> -->
<!-- 									<i class="ace-icon fa fa-envelope-o"></i> -->
<!-- 									5 Messages -->
<!-- 								</li> -->

<!-- 								<li class="dropdown-content"> -->
<!-- 									<ul class="dropdown-menu dropdown-navbar"> -->
<!-- 										<li> -->
<!-- 											<a href="#" class="clearfix"> -->
<%-- 												<img src="${baseUrl }/images/avatars/avatar.png" class="msg-photo" alt="Alex's Avatar" /> --%>
<!-- 												<span class="msg-body"> -->
<!-- 													<span class="msg-title"> -->
<!-- 														<span class="blue">Alex:</span> -->
<!-- 														Ciao sociis natoque penatibus et auctor ... -->
<!-- 													</span> -->

<!-- 													<span class="msg-time"> -->
<!-- 														<i class="ace-icon fa fa-clock-o"></i> -->
<!-- 														<span>a moment ago</span> -->
<!-- 													</span> -->
<!-- 												</span> -->
<!-- 											</a> -->
<!-- 										</li> -->

<!-- 										<li> -->
<!-- 											<a href="#" class="clearfix"> -->
<%-- 												<img src="${baseUrl }/images/avatars/avatar3.png" class="msg-photo" alt="Susan's Avatar" /> --%>
<!-- 												<span class="msg-body"> -->
<!-- 													<span class="msg-title"> -->
<!-- 														<span class="blue">Susan:</span> -->
<!-- 														Vestibulum id ligula porta felis euismod ... -->
<!-- 													</span> -->

<!-- 													<span class="msg-time"> -->
<!-- 														<i class="ace-icon fa fa-clock-o"></i> -->
<!-- 														<span>20 minutes ago</span> -->
<!-- 													</span> -->
<!-- 												</span> -->
<!-- 											</a> -->
<!-- 										</li> -->

<!-- 										<li> -->
<!-- 											<a href="#" class="clearfix"> -->
<%-- 												<img src="${baseUrl }/images/avatars/avatar4.png" class="msg-photo" alt="Bob's Avatar" /> --%>
<!-- 												<span class="msg-body"> -->
<!-- 													<span class="msg-title"> -->
<!-- 														<span class="blue">Bob:</span> -->
<!-- 														Nullam quis risus eget urna mollis ornare ... -->
<!-- 													</span> -->

<!-- 													<span class="msg-time"> -->
<!-- 														<i class="ace-icon fa fa-clock-o"></i> -->
<!-- 														<span>3:15 pm</span> -->
<!-- 													</span> -->
<!-- 												</span> -->
<!-- 											</a> -->
<!-- 										</li> -->

<!-- 										<li> -->
<!-- 											<a href="#" class="clearfix"> -->
<%-- 												<img src="${baseUrl }/images/avatars/avatar2.png" class="msg-photo" alt="Kate's Avatar" /> --%>
<!-- 												<span class="msg-body"> -->
<!-- 													<span class="msg-title"> -->
<!-- 														<span class="blue">Kate:</span> -->
<!-- 														Ciao sociis natoque eget urna mollis ornare ... -->
<!-- 													</span> -->

<!-- 													<span class="msg-time"> -->
<!-- 														<i class="ace-icon fa fa-clock-o"></i> -->
<!-- 														<span>1:33 pm</span> -->
<!-- 													</span> -->
<!-- 												</span> -->
<!-- 											</a> -->
<!-- 										</li> -->

<!-- 										<li> -->
<!-- 											<a href="#" class="clearfix"> -->
<%-- 												<img src="${baseUrl }/images/avatars/avatar5.png" class="msg-photo" alt="Fred's Avatar" /> --%>
<!-- 												<span class="msg-body"> -->
<!-- 													<span class="msg-title"> -->
<!-- 														<span class="blue">Fred:</span> -->
<!-- 														Vestibulum id penatibus et auctor  ... -->
<!-- 													</span> -->

<!-- 													<span class="msg-time"> -->
<!-- 														<i class="ace-icon fa fa-clock-o"></i> -->
<!-- 														<span>10:09 am</span> -->
<!-- 													</span> -->
<!-- 												</span> -->
<!-- 											</a> -->
<!-- 										</li> -->
<!-- 									</ul> -->
<!-- 								</li> -->

<!-- 								<li class="dropdown-footer"> -->
<!-- 									<a href="inbox.html"> -->
<!-- 										See all messages -->
<!-- 										<i class="ace-icon fa fa-arrow-right"></i> -->
<!-- 									</a> -->
<!-- 								</li> -->
<!-- 							</ul> -->
<!-- 						</li> -->

						<li class="light-blue dropdown-modal">
							<a data-toggle="dropdown" href="#" class="dropdown-toggle">
								<img class="nav-user-photo" src="${baseUrl}/images/avatars/user.jpg" alt="Jason's Photo" />
								<span class="user-info">
									<small>Welcome,</small>
									<%out.print(leftNav.getName()); %>
								</span>

								<i class="ace-icon fa fa-caret-down"></i>
							</a>

							<ul class="user-menu dropdown-menu-right dropdown-menu dropdown-yellow dropdown-caret dropdown-close">
<!-- 								<li> -->
<!-- 									<a href="#"> -->
<!-- 										<i class="ace-icon fa fa-cog"></i> -->
<!-- 										Settings -->
<!-- 									</a> -->
<!-- 								</li> -->

<!-- 								<li> -->
<!-- 									<a href="profile.html"> -->
<!-- 										<i class="ace-icon fa fa-user"></i> -->
<!-- 										Profile -->
<!-- 									</a> -->
<!-- 								</li> -->

<!-- 								<li class="divider"></li> -->

								<li>
									<a href="${baseUrl }/webapi/validate/logout">
										<i class="ace-icon fa fa-power-off"></i>
										Logout
									</a>
								</li>
							</ul>
						</li>
					</ul>
				</div>
			</div><!-- /.navbar-container -->
		</div>
		
		<div class="main-container ace-save-state" id="main-container">
			<script type="text/javascript">
				try{ace.settings.loadState('main-container')}catch(e){}
			</script>
			<div id="sidebar" class="sidebar responsive ace-save-state">
				<script type="text/javascript">
					try{ace.settings.loadState('sidebar')}catch(e){}
				</script>
				<ul class="nav nav-list">
<!-- 					<li class=""> -->
<!-- 						<a href="index.html"> -->
<!-- 							<i class="menu-icon fa fa-tachometer"></i> -->
<!-- 							<span class="menu-text"> Dashboard </span> -->
<!-- 						</a> -->
<!-- 						<b class="arrow"></b> -->
<!-- 					</li> -->
					<li class="active open">
						<a href="#" class="dropdown-toggle">
							<i class="menu-icon fa fa-list"></i>
							<span class="menu-text"> General </span>
							<b class="arrow fa fa-angle-down"></b>
						</a>
						<b class="arrow"></b>
						<ul class="submenu">
							<li class="">
								<a href="${baseUrl}/general/country.jsp"> 
									<i class="menu-icon fa fa-caret-right"></i> Country
								</a>
								<b class="arrow"></b>
							</li>
							<li class="">
								<a href="${baseUrl}/general/state.jsp"> 
									<i class="menu-icon fa fa-caret-right"></i> State
								</a> 
								<b class="arrow"></b>
							</li>
							<li class="">
								<a href="${baseUrl}/general/city.jsp"> 
									<i class="menu-icon fa fa-caret-right"></i> City
								</a> <b class="arrow"></b>
							</li>
							<li class="">
								<a href="${baseUrl}/general/locality.jsp"> 
									<i class="menu-icon fa fa-caret-right"></i> locality
								</a> 
								<b class="arrow"></b>
							</li>
								<li class="">
								<a href="${baseUrl}/general/area-unit.jsp"> 
									<i class="menu-icon fa fa-caret-right"></i> Area Unit
								</a> 
								<b class="arrow"></b>
							</li>
								<li class="">
								<a href="${baseUrl}/general/home-loan-bank.jsp"> 
									<i class="menu-icon fa fa-caret-right"></i> Home loan bank
								</a> 
								<b class="arrow"></b>
							</li>
						</ul>
					</li>
					<li class="active open">
						<a href="#" class="dropdown-toggle"> 
							<i class="menu-icon fa fa-pencil-square-o"></i> 
							<span class="menu-text"> Create Projects </span> <b class="arrow fa fa-angle-down"></b>
						</a> 
						<b class="arrow"></b>
						<ul class="submenu">
<li class=""><a href="${baseUrl}/createprojects/builder-project-amenity.jsp"> <i
				class="menu-icon fa fa-caret-right"></i> Project amenity
		</a> <b class="arrow"></b></li>
			<li class=""><a href="${baseUrl}/createprojects/builder-project-amenity-stages.jsp"> <i
				class="menu-icon fa fa-caret-right"></i> Project amenity stages
		</a> <b class="arrow"></b></li>
		</a> <b class="arrow"></b></li>
			<li class=""><a href="${baseUrl}/createprojects/builder-project-amenity-substages.jsp"> <i
				class="menu-icon fa fa-caret-right"></i> Project amenity sub stages
		</a> <b class="arrow"></b></li>
<li class=""><a href="${baseUrl}/createprojects/builder-building-amenity.jsp"> <i
				class="menu-icon fa fa-caret-right"></i> Building amenity
		</a> <b class="arrow"></b></li>
			<li class=""><a href="${baseUrl}/createprojects/builder-building-amenity-stages.jsp"> <i
				class="menu-icon fa fa-caret-right"></i> Building amenity stages
		</a> <b class="arrow"></b></li>
		</a> <b class="arrow"></b></li>
			<li class=""><a href="${baseUrl}/createprojects/builder-building-amenity-substages.jsp"> <i
				class="menu-icon fa fa-caret-right"></i> Building amenity sub stages
		</a> <b class="arrow"></b></li>
		<li class=""><a href="${baseUrl}/createprojects/builder-floor-amenity.jsp"> <i
				class="menu-icon fa fa-caret-right"></i> Floor amenity
		</a> <b class="arrow"></b></li>
			<li class=""><a href="${baseUrl}/createprojects/builder-floor-amenity-stages.jsp"> <i
				class="menu-icon fa fa-caret-right"></i> Floor amenity stages
		</a> <b class="arrow"></b></li>
		</a> <b class="arrow"></b></li>
			<li class=""><a href="${baseUrl}/createprojects/builder-floor-amenity-substages.jsp"> <i
				class="menu-icon fa fa-caret-right"></i> Floor amenity sub stages
		</a> <b class="arrow"></b></li>
			<li class=""><a href="${baseUrl}/createprojects/builder-flat-amenity.jsp"> <i
				class="menu-icon fa fa-caret-right"></i> Flat amenity
		</a> <b class="arrow"></b></li>
			<li class=""><a href="${baseUrl}/createprojects/builder-flat-amenity-stages.jsp"> <i
				class="menu-icon fa fa-caret-right"></i> Flat amenity stages
		</a> <b class="arrow"></b></li>
			<li class=""><a href="${baseUrl}/createprojects/builder-flat-amenity-substages.jsp"> <i
				class="menu-icon fa fa-caret-right"></i> Flat amenity sub stages
		</a> <b class="arrow"></b></li>
		<li class=""><a href="${baseUrl}/createprojects/builder-payment-stages.jsp"> <i
				class="menu-icon fa fa-caret-right"></i> Payment stages
		</a> <b class="arrow"></b></li>
			<li class=""><a href="${baseUrl}/createprojects/builder-payment-substages.jsp"> <i
				class="menu-icon fa fa-caret-right"></i> Payment sub stages
		</a> <b class="arrow"></b></li>
	<li class=""><a href="${baseUrl}/createprojects/building-status.jsp"> <i
				class="menu-icon fa fa-caret-right"></i> Building Status
		</a> <b class="arrow"></b></li>
<%-- 		<li class=""><a href="${baseUrl}/createprojects/builder-company.jsp"> <i --%>
<!-- 				class="menu-icon fa fa-caret-right"></i> Builder Company -->
<!-- 		</a> <b class="arrow"></b></li> -->
			<li class=""><a href="${baseUrl}/createprojects/builder-flat-status.jsp"> <i
				class="menu-icon fa fa-caret-right"></i> Flat status
		</a> <b class="arrow"></b></li>
<%-- 			<li class=""><a href="${baseUrl}/createprojects/builder-group.jsp"> <i --%>
<!-- 				class="menu-icon fa fa-caret-right"></i> Builder Group -->
<!-- 		</a> <b class="arrow"></b></li> -->
			<li class=""><a href="${baseUrl}/createprojects/builder-overall-project-stages-and-sub-stages.jsp"> <i
				class="menu-icon fa fa-caret-right"></i> Overall project stages and sub stages
		</a> <b class="arrow"></b></li>
			<li class=""><a href="${baseUrl}/createprojects/builder-project-approval-type.jsp"> <i
				class="menu-icon fa fa-caret-right"></i> Project approval type
		</a> <b class="arrow"></b></li>
			<li class=""><a href="${baseUrl}/createprojects/builder-project-level.jsp"> <i
				class="menu-icon fa fa-caret-right"></i> Project level
		</a> <b class="arrow"></b></li>
			<li class=""><a href="${baseUrl}/createprojects/builder-project-property-configuration.jsp"> <i
				class="menu-icon fa fa-caret-right"></i> Project property configuration
		</a> <b class="arrow"></b></li>
			<li class=""><a href="${baseUrl}/createprojects/builder-project-status.jsp"> <i
				class="menu-icon fa fa-caret-right"></i> Project status
		</a> <b class="arrow"></b></li>
			<li class=""><a href="${baseUrl}/createprojects/builder-project-type.jsp"> <i
				class="menu-icon fa fa-caret-right"></i> Project type
		</a> <b class="arrow"></b></li>
			<li class=""><a href="${baseUrl}/createprojects/builder-property-type.jsp"> <i
				class="menu-icon fa fa-caret-right"></i> Property type
		</a> <b class="arrow"></b></li>
			<li class=""><a href="${baseUrl}/createprojects/builder-seller-type.jsp"> <i
				class="menu-icon fa fa-caret-right"></i> seller type
		</a> <b class="arrow"></b></li>
<%-- 			<li class=""><a href="${baseUrl}/createprojects/builder-tax-type.jsp"> <i --%>
<!-- 				class="menu-icon fa fa-caret-right"></i> Tax type -->
<!-- 		</a> <b class="arrow"></b></li> -->
		<li class=""><a href="${baseUrl}/createprojects/tax.jsp"> <i
				class="menu-icon fa fa-caret-right"></i> Tax
		</a> <b class="arrow"></b></li>
						</ul>
					</li>
						<li class="active open">
						<a href="#" class="dropdown-toggle"> 
							<i class="menu-icon fa fa-pencil-square-o"></i> 
							<span class="menu-text"> Create Builders </span> <b class="arrow fa fa-angle-down"></b>
						</a> 
						<b class="arrow"></b>
						<ul class="submenu">
						<li class="active"><a href="${baseUrl}/createbuilder/addbuilder.jsp"> <i
				class="menu-icon fa fa-caret-right"></i> Add Builder
		</a> <b class="arrow"></b></li>
		</ul>
		</li>
		<li class="active open">
			<a href="#" class="dropdown-toggle"> 
				<i class="menu-icon fa fa-pencil-square-o"></i> 
				<span class="menu-text"> Project </span> <b class="arrow fa fa-angle-down"></b>
			</a> 
			<b class="arrow"></b>
			<ul class="submenu">
				<li class="active">
					<a href="${baseUrl}/admin/project/list.jsp"> 
						<i class="menu-icon fa fa-caret-right"></i> Manage Projects
					</a> <b class="arrow"></b>
				</li>
			</ul>
		</li>
		<li class="active open">
			<a href="#" class="dropdown-toggle"> 
				<i class="menu-icon fa fa-pencil-square-o"></i> 
				<span class="menu-text"> Leads </span> <b class="arrow fa fa-angle-down"></b>
			</a> 
			<b class="arrow"></b>
			<ul class="submenu">
				<li class="active">
					<a href="${baseUrl}/admin/leads/list.jsp"> 
						<i class="menu-icon fa fa-caret-right"></i> Manage Leads
					</a> <b class="arrow"></b>
				</li>
			</ul>
		</li>
		<li class="active open">
			<a href="#" class="dropdown-toggle"> 
				<i class="menu-icon fa fa-pencil-square-o"></i> 
				<span class="menu-text"> Buyers </span> <b class="arrow fa fa-angle-down"></b>
			</a> 
			<b class="arrow"></b>
			<ul class="submenu">
				<li class="active">
					<a href="${baseUrl}/admin/buyer/list.jsp"> 
						<i class="menu-icon fa fa-caret-right"></i> Manage Buyers
					</a> <b class="arrow"></b>
				</li>
			</ul>
		</li>
			<li class="active open">
			<a href="#" class="dropdown-toggle"> 
				<i class="menu-icon fa fa-pencil-square-o"></i> 
				<span class="menu-text"> Agreement </span> <b class="arrow fa fa-angle-down"></b>
			</a> 
			<b class="arrow"></b>
			<ul class="submenu">
				<li class="active">
					<a href="${baseUrl}/builder/buyer/agreement/list.jsp"> 
						<i class="menu-icon fa fa-caret-right"></i> Manage Agreement
					</a> <b class="arrow"></b>
				</li>
			</ul>
		</li>
			<div class="sidebar-toggle sidebar-collapse" id="sidebar-collapse">
				<i id="sidebar-toggle-icon" class="ace-icon fa fa-angle-double-left ace-save-state"
					data-icon1="ace-icon fa fa-angle-double-left"
					data-icon2="ace-icon fa fa-angle-double-right"></i>
			</div>
		</div>
