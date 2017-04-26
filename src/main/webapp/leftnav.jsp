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
	}
}
                        
%>
<body class="no-skin">
	<div id="navbar" class="navbar navbar-default ace-save-state">
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
		</div>
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
				<li class="active">
					<a href="#" class="dropdown-toggle">
						<i class="menu-icon fa fa-list"></i>
						<span class="menu-text"> General Settings </span>
						<b class="arrow fa fa-angle-down"></b>
					</a>
					<b class="arrow"></b>
					<ul class="submenu">
						<li class="">
							<a href="${baseUrl}/admin/general/country.jsp"> 
								<i class="menu-icon fa fa-caret-right"></i> Country
							</a>
							<b class="arrow"></b>
						</li>
						<li class="">
							<a href="${baseUrl}/admin/general/state.jsp"> 
								<i class="menu-icon fa fa-caret-right"></i> State
							</a> 
							<b class="arrow"></b>
						</li>
						<li class="">
							<a href="${baseUrl}/admin/general/city.jsp"> 
								<i class="menu-icon fa fa-caret-right"></i> City
							</a> <b class="arrow"></b>
						</li>
						<li class="">
							<a href="${baseUrl}/admin/general/locality.jsp"> 
								<i class="menu-icon fa fa-caret-right"></i> locality
							</a> 
							<b class="arrow"></b>
						</li>
							<li class="">
							<a href="${baseUrl}/admin/general/area-unit.jsp"> 
								<i class="menu-icon fa fa-caret-right"></i> Area Unit
							</a> 
							<b class="arrow"></b>
						</li>
							<li class="">
							<a href="${baseUrl}/admin/general/home-loan-bank.jsp"> 
								<i class="menu-icon fa fa-caret-right"></i> Home loan bank
							</a> 
							<b class="arrow"></b>
						</li>
					</ul>
				</li>
				<li class="active">
					<a href="#" class="dropdown-toggle"> 
						<i class="menu-icon fa fa-pencil-square-o"></i> 
						<span class="menu-text"> Project Settings </span> <b class="arrow fa fa-angle-down"></b>
					</a> 
					<b class="arrow"></b>
					<ul class="submenu">
						<li class="">
							<a href="${baseUrl}/admin/project-settings/builder-project-amenity.jsp"> 
								<i class="menu-icon fa fa-caret-right"></i> Project Amenity
							</a> <b class="arrow"></b>
						</li>
						<li class="">
							<a href="${baseUrl}/admin/project-settings/builder-project-amenity-stages.jsp"> 
								<i class="menu-icon fa fa-caret-right"></i> Project Amenity Stages
							</a> <b class="arrow"></b>
						</li>
						<li class="">
							<a href="${baseUrl}/admin/project-settings/builder-project-amenity-substages.jsp"> 
								<i class="menu-icon fa fa-caret-right"></i> Project Amenity Sub Stages
							</a> <b class="arrow"></b>
						</li>
						<li class="">
							<a href="${baseUrl}/admin/project-settings/builder-building-amenity.jsp"> 
								<i class="menu-icon fa fa-caret-right"></i> Building Amenity
							</a> <b class="arrow"></b>
						</li>
						<li class="">
							<a href="${baseUrl}/admin/project-settings/builder-building-amenity-stages.jsp"> 
								<i class="menu-icon fa fa-caret-right"></i> Building Amenity Stages
							</a> <b class="arrow"></b>
						</li>
						<li class="">
							<a href="${baseUrl}/admin/project-settings/builder-building-amenity-substages.jsp"> 
								<i class="menu-icon fa fa-caret-right"></i> Building Amenity Sub Stages
							</a> <b class="arrow"></b>
						</li>
						<li class="">
							<a href="${baseUrl}/admin/project-settings/builder-floor-amenity.jsp"> 
								<i class="menu-icon fa fa-caret-right"></i> Floor Amenity
							</a> <b class="arrow"></b>
						</li>
						<li class="">
							<a href="${baseUrl}/admin/project-settings/builder-floor-amenity-stages.jsp"> 
								<i class="menu-icon fa fa-caret-right"></i> Floor Amenity Stages
							</a> <b class="arrow"></b>
						</li>
						<li class="">
							<a href="${baseUrl}/admin/project-settings/builder-floor-amenity-substages.jsp"> 
								<i class="menu-icon fa fa-caret-right"></i> Floor Amenity Sub Stages
							</a> <b class="arrow"></b>
						</li>
						<li class="">
							<a href="${baseUrl}/admin/project-settings/builder-flat-amenity.jsp"> 
								<i class="menu-icon fa fa-caret-right"></i> Flat Amenity
							</a> <b class="arrow"></b>
						</li>
						<li class="">
							<a href="${baseUrl}/admin/project-settings/builder-flat-amenity-stages.jsp"> 
								<i class="menu-icon fa fa-caret-right"></i> Flat Amenity Stages
							</a> <b class="arrow"></b>
						</li>
						<li class="">
							<a href="${baseUrl}/admin/project-settings/builder-flat-amenity-substages.jsp"> 
								<i class="menu-icon fa fa-caret-right"></i> Flat Amenity Sub Stages
							</a> <b class="arrow"></b>
						</li>
						<li class="">
							<a href="${baseUrl}/admin/project-settings/builder-payment-stages.jsp"> 
								<i class="menu-icon fa fa-caret-right"></i> Payment Stages
							</a> <b class="arrow"></b>
						</li>
						<li class="">
							<a href="${baseUrl}/admin/project-settings/builder-payment-substages.jsp"> 
								<i class="menu-icon fa fa-caret-right"></i> Payment Sub Stages
							</a> <b class="arrow"></b>
						</li>
						<li class="">
							<a href="${baseUrl}/admin/project-settings/building-status.jsp"> 
								<i class="menu-icon fa fa-caret-right"></i> Building Status
							</a> <b class="arrow"></b>
						</li>
						<li class="">
							<a href="${baseUrl}/admin/project-settings/builder-flat-status.jsp"> 
								<i class="menu-icon fa fa-caret-right"></i> Flat Status
							</a> <b class="arrow"></b>
						</li>
						<li class="">
							<a href="${baseUrl}/admin/project-settings/builder-overall-project-stages-and-sub-stages.jsp"> 
								<i class="menu-icon fa fa-caret-right"></i> Overall Project Stages & Sub Stages
							</a> <b class="arrow"></b>
						</li>
						<li class="">
							<a href="${baseUrl}/admin/project-settings/builder-project-approval-type.jsp"> 
								<i class="menu-icon fa fa-caret-right"></i> Project Approval Type
							</a> <b class="arrow"></b>
						</li>
						<li class="">
							<a href="${baseUrl}/admin/project-settings/builder-project-level.jsp"> 
								<i class="menu-icon fa fa-caret-right"></i> Project Level
							</a> <b class="arrow"></b>
						</li>
						<li class="">
							<a href="${baseUrl}/admin/project-settings/builder-project-property-configuration.jsp"> 
								<i class="menu-icon fa fa-caret-right"></i> Project Property Configuration
							</a> <b class="arrow"></b>
						</li>
						<li class="">
							<a href="${baseUrl}/admin/project-settings/builder-project-status.jsp"> 
								<i class="menu-icon fa fa-caret-right"></i> Project Status
							</a> <b class="arrow"></b>
						</li>
						<li class="">
							<a href="${baseUrl}/admin/project-settings/builder-project-type.jsp"> 
								<i class="menu-icon fa fa-caret-right"></i> Project Type
							</a> <b class="arrow"></b>
						</li>
						<li class="">
							<a href="${baseUrl}/admin/project-settings/builder-property-type.jsp"> 
								<i class="menu-icon fa fa-caret-right"></i> Property Type
							</a> <b class="arrow"></b>
						</li>
						<li class="">
							<a href="${baseUrl}/admin/project-settings/builder-seller-type.jsp"> 
								<i class="menu-icon fa fa-caret-right"></i> Seller Type
							</a> <b class="arrow"></b>
						</li>
						<li class="">
							<a href="${baseUrl}/admin/project-settings/tax.jsp"> 
								<i class="menu-icon fa fa-caret-right"></i> Tax By Pincode
							</a> <b class="arrow"></b>
						</li>
					</ul>
				</li>
				<li class="active">
					<a href="#" class="dropdown-toggle"> 
						<i class="menu-icon fa fa-pencil-square-o"></i> 
						<span class="menu-text"> Builder </span> <b class="arrow fa fa-angle-down"></b>
					</a> 
					<b class="arrow"></b>
					<ul class="submenu">
						<li>
							<a href="${baseUrl}/admin/project-settings/addbuilder.jsp"> 
								<i class="menu-icon fa fa-caret-right"></i> Manage Builder
							</a> <b class="arrow"></b>
						</li>
					</ul>
				</li>
				<li class="active">
					<a href="#" class="dropdown-toggle"> 
						<i class="menu-icon fa fa-pencil-square-o"></i> 
						<span class="menu-text"> Project </span> <b class="arrow fa fa-angle-down"></b>
					</a> 
					<b class="arrow"></b>
					<ul class="submenu">
						<li class="">
							<a href="${baseUrl}/admin/project/list.jsp"> 
								<i class="menu-icon fa fa-caret-right"></i> Manage Projects
							</a> <b class="arrow"></b>
						</li>
						<li class="">
							<a href="${baseUrl}/admin/project/building/list.jsp"> 
								<i class="menu-icon fa fa-caret-right"></i> Manage Buildings
							</a> <b class="arrow"></b>
						</li>
						<li class="">
							<a href="${baseUrl}/admin/project/building/floor/list.jsp"> 
								<i class="menu-icon fa fa-caret-right"></i> Manage Floors
							</a> <b class="arrow"></b>
						</li>
						<li class="">
							<a href="${baseUrl}/admin/project/building/flattype/list.jsp"> 
								<i class="menu-icon fa fa-caret-right"></i> Manage Flat Types
							</a> <b class="arrow"></b>
						</li>
						<li class="">
							<a href="${baseUrl}/admin/project/building/floor/flat/list.jsp"> 
								<i class="menu-icon fa fa-caret-right"></i> Manage Flats
							</a> <b class="arrow"></b>
						</li>
					</ul>
				</li>
				<li class="active">
					<a href="#" class="dropdown-toggle"> 
						<i class="menu-icon fa fa-pencil-square-o"></i> 
						<span class="menu-text"> Employees </span> <b class="arrow fa fa-angle-down"></b>
					</a> 
					<b class="arrow"></b>
					<ul class="submenu">
						<li class="active">
							<a href="${baseUrl}/admin/employee/list.jsp"> 
								<i class="menu-icon fa fa-caret-right"></i> Manage Employees
							</a> <b class="arrow"></b>
						</li>
					</ul>
				</li>
				<li class="active">
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
				<li class="active">
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
				<li class="active">
					<a href="#" class="dropdown-toggle"> 
						<i class="menu-icon fa fa-pencil-square-o"></i> 
						<span class="menu-text"> DemandLetters </span> <b class="arrow fa fa-angle-down"></b>
					</a> 
					<b class="arrow"></b>
					<ul class="submenu">
						<li class="active">
							<a href="${baseUrl}/admin/buyer/demandletters/list.jsp"> 
								<i class="menu-icon fa fa-caret-right"></i> Manage Demand Letters
							</a> <b class="arrow"></b>
						</li>
					</ul>
				</li>
				<li class="active">
					<a href="#" class="dropdown-toggle"> 
						<i class="menu-icon fa fa-pencil-square-o"></i> 
						<span class="menu-text"> Agreement </span> <b class="arrow fa fa-angle-down"></b>
					</a> 
					<b class="arrow"></b>
					<ul class="submenu">
						<li class="active">
							<a href="${baseUrl}/admin/buyer/agreement/list.jsp"> 
								<i class="menu-icon fa fa-caret-right"></i> Manage Agreement
							</a> <b class="arrow"></b>
						</li>
					</ul>
				</li>
				<li class="active">
					<a href="#" class="dropdown-toggle"> 
						<i class="menu-icon fa fa-pencil-square-o"></i> 
						<span class="menu-text"> Possession </span> <b class="arrow fa fa-angle-down"></b>
					</a> 
					<b class="arrow"></b>
					<ul class="submenu">
						<li class="active">
							<a href="${baseUrl}/admin/buyer/possession/list.jsp"> 
								<i class="menu-icon fa fa-caret-right"></i> Manage Possession
							</a> <b class="arrow"></b>
						</li>
					</ul>
				</li>
				<li class="active">
					<a href="#" class="dropdown-toggle"> 
						<i class="menu-icon fa fa-pencil-square-o"></i> 
						<span class="menu-text"> Campaign </span> <b class="arrow fa fa-angle-down"></b>
					</a> 
					<b class="arrow"></b>
					<ul class="submenu">
						<li class="active">
							<a href="${baseUrl}/admin/campaign/list.jsp"> 
								<i class="menu-icon fa fa-caret-right"></i> Manage Campaign
							</a> <b class="arrow"></b>
						</li>
					</ul>
				</li>
					<li class="active">
					<a href="#" class="dropdown-toggle"> 
						<i class="menu-icon fa fa-pencil-square-o"></i> 
						<span class="menu-text"> Project Update</span> <b class="arrow fa fa-angle-down"></b>
					</a> 
					<b class="arrow"></b>
					<ul class="submenu">
						<li class="active">
							<a href="${baseUrl}/admin/buyer/update-buyers/list.jsp"> 
								<i class="menu-icon fa fa-caret-right"></i>Project Update
							</a> <b class="arrow"></b>
						</li>
					</ul>
				</li>
			</ul>
			<div class="sidebar-toggle sidebar-collapse" id="sidebar-collapse">
				<i id="sidebar-toggle-icon" class="ace-icon fa fa-angle-double-left ace-save-state"
					data-icon1="ace-icon fa fa-angle-double-left"
					data-icon2="ace-icon fa fa-angle-double-right"></i>
			</div>
		</div>