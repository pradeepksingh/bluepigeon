    <script src="../bootstrap/dist/js/tether.min.js"></script>
    <script src="../bootstrap/dist/js/bootstrap.min.js"></script>
       <script src="../plugins/bower_components/bootstrap-extension/js/bootstrap-extension.min.js"></script>
    <!-- Menu Plugin JavaScript -->
    <script src="../plugins/bower_components/sidebar-nav/dist/sidebar-nav.min.js"></script>
    <!--slimscroll JavaScript -->
    <script src="../js/jquery.slimscroll.js"></script>
    <!--Wave Effects -->
    <script src="../js/waves.js"></script>
    <!-- Custom Theme JavaScript -->
    <script src="../js/custom.min.js"></script>
    <!--Morris JavaScript -->
   <script src="../plugins/bower_components/datatables/jquery.dataTables.min.js"></script>
    <!-- Footable -->
    <script src="../plugins/bower_components/footable/js/footable.all.min.js"></script>
    <script src="../plugins/bower_components/bootstrap-select/bootstrap-select.min.js" type="text/javascript"></script>
    <!--FooTable init-->
    <script src="../js/footable-init.js"></script>
    <!--Style Switcher -->
    <script src="../plugins/bower_components/styleswitcher/jQuery.style.switcher.js"></script>

     <div class="navbar-default sidebar" role="navigation">
            <div class="sidebar-nav navbar-collapse slimscrollsidebar">
                <ul class="nav" id="side-menu">
<!--                     <li class="sidebar-search hidden-sm hidden-md hidden-lg"> -->
<!--                         input-group -->
<!--                         <div class="input-group custom-search-form"> -->
<!--                             <input type="text" class="form-control" placeholder="Search..."> <span class="input-group-btn"> -->
<!--             <button class="btn btn-default" type="button"> <i class="fa fa-search"></i> </button> -->
<!--             </span> </div> -->
<!--                         /input-group -->
<!--                     </li> -->
<!--                     <li class="user-pro"> -->
<!--                         <a href="#" class="waves-effect"><img src="../plugins/images/users/d1.jpg" alt="user-img" class="img-circle"> <span class="hide-menu">Steve Gection<span class="fa arrow"></span></span> -->
<!--                         </a> -->
<!--                         <ul class="nav nav-second-level"> -->
<!--                             <li><a href="javascript:void(0)"><i class="ti-user"></i> My Profile</a></li> -->
<!--                             <li><a href="javascript:void(0)"><i class="ti-email"></i> Inbox</a></li> -->
<!--                             <li><a href="javascript:void(0)"><i class="ti-settings"></i> Account Setting</a></li> -->
<!--                             <li><a href="javascript:void(0)"><i class="fa fa-power-off"></i> Logout</a></li> -->
<!--                         </ul> -->
<!--                     </li> -->
                    
<!--                     <li> <a href="index.html" class="waves-effect"><i class="ti-dashboard p-r-10"></i> <span class="hide-menu">Dashboard</span></a> </li> -->
                    <li> <a href="javascript:void(0);" class="waves-effect"><i class="linea-icon linea-basic fa-fw text-danger" data-icon="7"></i> <span class="hide-menu text-danger"> New Project Launch <span class="fa arrow"></span> 
                    </span></a>
                        <ul class="nav nav-second-level">
                            <li> <a href="${baseUrl }/bluepigeon/builder/project/list.jsp">Manage Project</a> </li>
<!--                             <li> <a href="">Manage Building</a> </li> -->
<!--                             <li> <a href="">Manage Flat</a> </li> -->
                        </ul>
                    </li>
<!--                     <li> <a href="javascript:void(0);" class="waves-effect"><i data-icon="/" class="linea-icon linea-basic fa-fw"></i><span class="hide-menu"> Employee<span class="fa arrow"></span></span></a> -->
<!--                         <ul class="nav nav-second-level"> -->
<!--                             <li> <a href="inbox.html">Add Employee</a></li> -->
<!--                             <li> <a href="inbox-detail.html">Manage Employee</a></li> -->
<!--                         </ul> -->
<!--                     </li> -->
<!--                     <li> <a href="javascript:void(0);" class="waves-effect"><i class="ti-layout fa-fw"></i><span class="hide-menu"> Marketing<span class="fa arrow"></span></span></a> -->
<!--                         <ul class="nav nav-second-level"> -->
<!--                             <li> <a href="inbox.html">Manage Updates</a></li> -->
<!--                             <li> <a href="inbox-detail.html">New Campaign</a></li> -->
<!--                             <li> <a href="inbox.html">Referral</a></li> -->
<!--                         </ul> -->
<!--                     </li> -->
<!--                     <li> <a href="javascript:void(0);" class="waves-effect"><i data-icon="F" class="linea-icon linea-software fa-fw"></i><span class="hide-menu"> Owner Management<span class="fa arrow"></span></span></a> -->
<!--                         <ul class="nav nav-second-level"> -->
<!--                             <li> <a href="inbox.html">Manage Buyers</a></li> -->
<!--                             <li> <a href="inbox-detail.html">Manage Leads</a></li> -->
<!--                             <li> <a href="inbox.html">Demand Letter Release</a></li> -->
<!--                             <li> <a href="inbox.html">Allot Possession</a></li> -->
<!--                             <li> <a href="inbox.html">Cancellation</a></li> -->
<!--                         </ul> -->
<!--                     </li> -->
                    <li> <a href="javascript:void(0);" class="waves-effect"><i class="icon-envelope p-r-10"></i> <span class="hide-menu">Create Letters <span class="fa arrow"></span></span></a>
                     <ul class="nav nav-second-level">
                            <li> <a href="${baseUrl }/bluepigeon/builder/demandletters/list.jsp">Manage Demand Letters</a></li>
                            <li> <a href="${baseUrl }/bluepigeon/builder/agreement/list.jsp">Manage Agreement Letters</a></li>
                            <li> <a href="${baseUrl }/bluepigeon/builder/possession/list.jsp">Manage Possession Letter</a></li>
<!--                             <li> <a href="inbox.html">Allot Possession</a></li> -->
<!--                             <li> <a href="inbox.html">Cancellation</a></li> -->
                        </ul>
                    </li>
                </ul>
            </div>
        </div>