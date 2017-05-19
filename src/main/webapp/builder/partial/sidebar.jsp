<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="req" value="${pageContext.request}" />
<c:set var="url">${req.requestURL}</c:set>
<c:set var="uri" value="${req.requestURI}" />
<c:set var="baseUrl" value="${fn:substring(url, 0, fn:length(url) - fn:length(uri))}${req.contextPath}" />
     <div class="navbar-default sidebar" role="navigation">
            <div class="sidebar-nav navbar-collapse slimscrollsidebar">
                <ul class="nav" id="side-menu">
                    <li class="sidebar-search hidden-sm hidden-md hidden-lg">
                        input-group
                        <div class="input-group custom-search-form">
                            <input type="text" class="form-control" placeholder="Search..."> <span class="input-group-btn">
            <button class="btn btn-default" type="button"> <i class="fa fa-search"></i> </button>
            </span> </div>
                        /input-group
                    </li>
                    <li class="user-pro">
                        <a href="#" class="waves-effect"><img src="${baseUrl }/builder/plugins/images/users/d1.jpg" alt="user-img" class="img-circle"> <span class="hide-menu">Steve Gection<span class="fa arrow"></span></span>
                        </a>
                        <ul class="nav nav-second-level">
                            <li><a href="javascript:void(0)"><i class="ti-user"></i> My Profile</a></li>
                            <li><a href="javascript:void(0)"><i class="ti-email"></i> Inbox</a></li>
                            <li><a href="javascript:void(0)"><i class="ti-settings"></i> Account Setting</a></li>
                            <li><a href="javascript:void(0)"><i class="fa fa-power-off"></i> Logout</a></li>
                        </ul>
                    </li>
                    <li class="nav-small-cap m-t-10">--Main Menu--</li>
                    <li> <a href="${baseUrl }/builder/dashboard.jsp" class="waves-effect"><i class="ti-dashboard p-r-10"></i> <span class="hide-menu">Dashboard</span></a> </li>
                    <li> <a href="javascript:void(0);" class="waves-effect"><i class="linea-icon linea-basic fa-fw" data-icon="7"></i> <span class="hide-menu">Project<span class="fa arrow"></span> 
                    </span></a>
                        <ul class="nav nav-second-level">
<%--                             <li> <a href="${baseUrl }/builder/project/new.jsp">Add</a> </li> --%>
                            <li> <a href="${baseUrl }/builder/project/list.jsp">Manage Project</a></li>
                             <li> <a href="${baseUrl }/builder/project/building/list.jsp">Manage Buildings</a></li>
                              <li> <a href="${baseUrl }/builder/project/building/floor/list.jsp">Manage Floor</a></li>
                             <li> <a href="${baseUrl }/builder/project/building/flat/list.jsp">Manage Flat</a></li>
                         </ul>
                    </li>
<!--                      <li> <a href="javascript:void(0);" class="waves-effect"><i data-icon="/" class="ti-home fa-fw"></i><span class="hide-menu">Building<span class="fa arrow"></span></span></a> -->
<!--                         <ul class="nav nav-second-level"> -->
<!--                             <li> <a href="inbox.html">Add</a></li> -->
<!--                             <li> <a href="inbox-detail.html">Manage</a></li> -->
<!--                         </ul> -->
<!--                     </li> -->
                     <li> <a href="javascript:void(0);" class="waves-effect"><i data-icon="/" class="ti-layout fa-fw"></i><span class="hide-menu"> Buyer<span class="fa arrow"></span></span></a>
                        <ul class="nav nav-second-level">
                            <li> <a href="${baseUrl }/builder/buyer/new.jsp">Add</a></li>
<!--                             <li> <a href="index.html">Manage</a></li> -->
                        </ul>
                    </li>
                    <li> <a href="javascript:void(0);" class="waves-effect"><i data-icon="/" class="linea-icon linea-basic fa-fw"></i><span class="hide-menu"> Employee<span class="fa arrow"></span></span></a>
                        <ul class="nav nav-second-level">
                            <li> <a href="${baseUrl }/builder/employee/new.jsp">Add</a></li>
                            <li> <a href="${baseUrl }/builder/employee/list.jsp">Manage</a></li>
                        </ul>
                    </li>
<!--                      <li> <a href="javascript:void(0);" class="waves-effect"><i data-icon="/" class="linea-icon linea-basic fa-fw"></i><span class="hide-menu">Campaign<span class="fa arrow"></span></span></a> -->
<!--                         <ul class="nav nav-second-level"> -->
<!--                             <li> <a href="inbox.html">Add</a></li> -->
<!--                             <li> <a href="inbox-detail.html">Manage</a></li> -->
<!--                         </ul> -->
<!--                     </li> -->
                     <li class="nav-small-cap m-t-10">--Professional--</li>
                     <li> <a href="javascript:void(0);" class="waves-effect"><i class="ti-layout fa-fw"></i><span class="hide-menu"> Sales<span class="fa arrow"></span></span></a>
                        <ul class="nav nav-second-level">
<!--                             <li> <a href="inbox.html">Add</a></li> -->
<!--                             <li> <a href="inbox-detail.html">Manage</a></li> -->
                              <li> <a href="${baseUrl }/builder/leads/list.jsp">Manage Leads</a></li>
                             </ul>
                    </li>
                    <li> <a href="javascript:void(0);" class="waves-effect"><i class="ti-layout fa-fw"></i><span class="hide-menu"> Marketing<span class="fa arrow"></span></span></a>
                        <ul class="nav nav-second-level">
<!--                             <li> <a href="inbox.html">Manage Updates</a></li> -->
                            <li> <a href="${baseUrl }/builder/campaign/list.jsp">New Campaign</a></li>
                             </ul>
                    </li>
                    <li> <a href="javascript:void(0);" class="waves-effect"><i data-icon="F" class="linea-icon linea-software fa-fw"></i><span class="hide-menu"> Inventory<span class="fa arrow"></span></span></a>
                        <ul class="nav nav-second-level">
                            <li> <a href="${baseUrl }/builder/demandletters/list.jsp">Demand Letter Release</a></li>
                            <li> <a href="${baseUrl }/builder/possession/list.jsp">Allot Possession</a></li>
                            <li> <a href="${baseUrl }/builder/cancellation/list.jsp">Cancellation</a></li>
                        </ul>
                    </li>
 					<li class="nav-small-cap m-t-10">--Support--</li>
                    <li> <a href="javascript:void(0);" class="waves-effect"><i class="icon-envelope p-r-10"></i> <span class="hide-menu"> Settings<span class="fa arrow"></span></span></a>
                    </li>
                     <li> <a href="javascript:void(0);" class="waves-effect"><i class="icon-envelope p-r-10"></i> <span class="hide-menu"> Contact Us<span class="fa arrow"></span></span></a>
                    </li>
                </ul>
            </div>
        </div>