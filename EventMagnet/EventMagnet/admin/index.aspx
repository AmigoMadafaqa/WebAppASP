<%@ Page Title="" Language="C#" MasterPageFile="~/admin/admin.Master" AutoEventWireup="true" CodeBehind="index.aspx.cs" Inherits="EventMagnet.admin.index" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<!-- Content -->
    <asp:Literal ID="testtest" runat="server"></asp:Literal>
    
<div class="container-xxl flex-grow-1 container-p-y">
   <div class="row">
      <div class="col-lg-8 mb-4 order-0">
         <div class="card">
            <div class="d-flex align-items-end row">
               <div class="col-sm-7">
                  <div class="card-body">
                     <h5 class="card-title text-primary">Hello John! 🎉</h5>
                     <p class="mb-4">
                        You have <span class="fw-bold">20%</span> more peole joined and create event. 
                     </p>
                     <a href="javascript:;" class="btn btn-sm btn-outline-primary">View Event</a>
                  </div>
               </div>
               <div class="col-sm-5 text-center text-sm-left">
                  <div class="card-body pb-0 px-0 px-md-4">
                     <img
                        src="images/illustration/man-with-laptop-light.png"
                        height="140"
                        alt="View Badge User"
                        data-app-dark-img="illustration/man-with-laptop-dark.png"
                        data-app-light-img="illustration/man-with-laptop-light.png"
                        />
                  </div>
               </div>
            </div>
         </div>
      </div>
      <div class="col-lg-4 col-md-4 order-1">
         <div class="row">
            <div class="col-lg-6 col-md-12 col-6 mb-4">
               <div class="card">
                  <div class="card-body">
                     <div class="card-title d-flex align-items-start justify-content-between">
                        <div class="avatar flex-shrink-0">
                           <img
                              src="images/icons/unicons/chart-success.png"
                              alt="chart success"
                              class="rounded"
                              />
                        </div>
                        <div class="dropdown">
                           <button
                              class="btn p-0"
                              type="button"
                              id="cardOpt3"
                              data-bs-toggle="dropdown"
                              aria-haspopup="true"
                              aria-expanded="false"
                              >
                           <i class="bx bx-dots-vertical-rounded"></i>
                           </button>
                           <div class="dropdown-menu dropdown-menu-end" aria-labelledby="cardOpt3">
                              <a class="dropdown-item" href="javascript:void(0);">View More</a>
                              <a class="dropdown-item" href="javascript:void(0);">Delete</a>
                           </div>
                        </div>
                     </div>
                     <span class="fw-semibold d-block mb-1">Customer</span>
                     <h3 class="card-title mb-2"><%= numOfCust.ToString() %></h3>
                     <small class="text-success fw-semibold"><i class="bx bx-up-arrow-alt"></i> +12.80%</small>
                  </div>
               </div>
            </div>
            <div class="col-lg-6 col-md-12 col-6 mb-4">
               <div class="card">
                  <div class="card-body">
                     <div class="card-title d-flex align-items-start justify-content-between">
                        <div class="avatar flex-shrink-0">
                           <img
                              src="images/icons/unicons/wallet-info.png"
                              alt="Credit Card"
                              class="rounded"
                              />
                        </div>
                        <div class="dropdown">
                           <button
                              class="btn p-0"
                              type="button"
                              id="cardOpt6"
                              data-bs-toggle="dropdown"
                              aria-haspopup="true"
                              aria-expanded="false"
                              >
                           <i class="bx bx-dots-vertical-rounded"></i>
                           </button>
                           <div class="dropdown-menu dropdown-menu-end" aria-labelledby="cardOpt6">
                              <a class="dropdown-item" href="javascript:void(0);">View More</a>
                              <a class="dropdown-item" href="javascript:void(0);">Delete</a>
                           </div>
                        </div>
                     </div>
                     <span>Event</span>
                     <h3 class="card-title text-nowrap mb-1"><%= numOfEvent.ToString() %></h3>
                     <small class="text-success fw-semibold"><i class="bx bx-up-arrow-alt"></i> +28.42%</small>
                  </div>
               </div>
            </div>
         </div>
      </div>
      <!-- Total Revenue -->
      <div class="col-12 col-lg-8 order-2 order-md-3 order-lg-2 mb-4">
         <div class="card">
            <div class="row row-bordered g-0">
               <div class="col-md-8">
                  <h5 class="card-header m-0 me-2 pb-3">Total Revenue</h5>
                  <%--<div id="totalRevenueChart" class="px-2"></div>--%>
                  <div id="totalRevenueChartWithExpenses" style="height:415px;"></div>
               </div>
               <div class="col-md-4">
                  <div class="card-body">
                     <div class="text-center">
                        <div class="dropdown">
                           <button
                              class="btn btn-sm btn-outline-primary dropdown-toggle"
                              type="button"
                              id="growthReportId"
                              data-bs-toggle="dropdown"
                              aria-haspopup="true"
                              aria-expanded="false"
                              >
                           2024
                           </button>
                            <div class="dropdown-menu dropdown-menu-end" aria-labelledby="growthReportId">
                              <a class="dropdown-item" href="javascript:void(0);">2023</a>
                              <a class="dropdown-item" href="javascript:void(0);">2022</a>
                              <a class="dropdown-item" href="javascript:void(0);">2021</a>
                           </div>
                        </div>
                     </div>
                  </div>
                  <div id="growthChart"></div>
                  <div class="text-center fw-semibold pt-3 mb-2">62% Revenue Growth</div>
                  <div class="d-flex px-xxl-4 px-lg-2 p-4 gap-xxl-3 gap-lg-1 gap-3 justify-content-between">
                     <div class="d-flex">
                        <div class="me-2">
                           <span class="badge bg-label-primary p-2"><i class="bx bx-dollar text-primary"></i></span>
                        </div>
                        <div class="d-flex flex-column">
                           <small>2024</small>
                           <h6 class="mb-0">RM <%= currentYearRevenue.ToString("0.00") %></h6>
                        </div>
                     </div>
                     <div class="d-flex">
                        <div class="me-2">
                           <span class="badge bg-label-info p-2"><i class="bx bx-wallet text-info"></i></span>
                        </div>
                        <div class="d-flex flex-column">
                           <small>2023</small>
                           <h6 class="mb-0">RM <%= previousYearRevenue.ToString("0.00") %></h6>
                        </div>
                     </div>
                  </div>
               </div>
            </div>
         </div>
      </div>
      <!--/ Total Revenue -->
      <div class="col-12 col-md-8 col-lg-4 order-3 order-md-2">
         <div class="row">
            <div class="col-6 mb-4">
               <div class="card">
                  <div class="card-body">
                     <div class="card-title d-flex align-items-start justify-content-between">
                        <div class="avatar flex-shrink-0">
                           <img src="images/icons/unicons/paypal.png" alt="Credit Card" class="rounded" />
                        </div>
                        <div class="dropdown">
                           <button
                              class="btn p-0"
                              type="button"
                              id="cardOpt4"
                              data-bs-toggle="dropdown"
                              aria-haspopup="true"
                              aria-expanded="false"
                              >
                           <i class="bx bx-dots-vertical-rounded"></i>
                           </button>
                           <div class="dropdown-menu dropdown-menu-end" aria-labelledby="cardOpt4">
                              <a class="dropdown-item" href="javascript:void(0);">View More</a>
                              <a class="dropdown-item" href="javascript:void(0);">Delete</a>
                           </div>
                        </div>
                     </div>
                     <span class="d-block mb-1">Payments</span>
                     <h3 class="card-title text-nowrap mb-2">RM <%= paymentAmount.ToString("0.00") %></h3>
                     <small class="text-danger fw-semibold"><i class="bx bx-down-arrow-alt"></i> -14.82%</small>
                  </div>
               </div>
            </div>
            <div class="col-6 mb-4">
               <div class="card">
                  <div class="card-body">
                     <div class="card-title d-flex align-items-start justify-content-between">
                        <div class="avatar flex-shrink-0">
                           <img src="images/icons/unicons/cc-primary.png" alt="Credit Card" class="rounded" />
                        </div>
                        <div class="dropdown">
                           <button
                              class="btn p-0"
                              type="button"
                              id="cardOpt1"
                              data-bs-toggle="dropdown"
                              aria-haspopup="true"
                              aria-expanded="false"
                              >
                           <i class="bx bx-dots-vertical-rounded"></i>
                           </button>
                           <div class="dropdown-menu" aria-labelledby="cardOpt1">
                              <a class="dropdown-item" href="javascript:void(0);">View More</a>
                              <a class="dropdown-item" href="javascript:void(0);">Delete</a>
                           </div>
                        </div>
                     </div>
                     <span class="fw-semibold d-block mb-1">Transactions</span>
                     <h3 class="card-title mb-2">RM <%= transactionAmount.ToString("0.00") %></h3>
                     <small class="text-success fw-semibold"><i class="bx bx-up-arrow-alt"></i> +28.14%</small>
                  </div>
               </div>
            </div>
            <!-- </div>
               <div class="row"> -->
            <div class="col-12 mb-4">
               <div class="card">
                  <div class="card-body">
                     <div class="d-flex justify-content-between flex-sm-row flex-column gap-3">
                        <div class="d-flex flex-sm-column flex-row align-items-start justify-content-between">
                           <div class="card-title">
                              <h5 class="text-nowrap mb-2">Profit Report</h5>
                              <span class="badge bg-label-warning rounded-pill">Year <%= DateTime.Now.Year.ToString() %></span>
                           </div>
                           <div class="mt-sm-auto">
                              <small class="text-success text-nowrap fw-semibold"
                                 ><i class="bx bx-chevron-up"></i> 68.2%</small
                                 >
                              <h3 class="mb-0">RM <%= profitAmount.ToString("0.00") %></h3>
                           </div>
                        </div>
                        <div id="profileReportChart"></div>
                     </div>
                  </div>
               </div>
            </div>
         </div>
      </div>
   </div>
   <div class="row">
      <!-- Order Statistics -->
      <div class="col-md-6 col-lg-4 col-xl-4 order-0 mb-4">
         <div class="card h-100">
            <div class="card-header d-flex align-items-center justify-content-between pb-0">
               <div class="card-title mb-0">
                  <h5 class="m-0 me-2">Order Statistics</h5>
                  <small class="text-muted"><%= totalOrder.ToString() %> Total Orders</small>
               </div>
               <div class="dropdown">
                  <button
                     class="btn p-0"
                     type="button"
                     id="orederStatistics"
                     data-bs-toggle="dropdown"
                     aria-haspopup="true"
                     aria-expanded="false"
                     >
                  <i class="bx bx-dots-vertical-rounded"></i>
                  </button>
                  <div class="dropdown-menu dropdown-menu-end" aria-labelledby="orederStatistics">
                     <a class="dropdown-item" href="javascript:void(0);">Select All</a>
                     <a class="dropdown-item" href="javascript:void(0);">Refresh</a>
                     <a class="dropdown-item" href="javascript:void(0);">Share</a>
                  </div>
               </div>
            </div>
            <div class="card-body">
               <div class="d-flex justify-content-between align-items-center mb-3">
                  <div class="d-flex flex-column align-items-center gap-1">
                     <h2 class="mb-2"><%= totalSales.ToString() %></h2>
                     <span>Total sales</span>
                  </div>
                  <div id="orderStatisticsChart"></div>
               </div>
               
            </div>
         </div>
      </div>
      <!--/ Order Statistics -->
      <!-- Expense Overview -->
      <div class="col-md-6 col-lg-4 order-1 mb-4">
         <div class="card h-100">
            <div class="card-header">
               <ul class="nav nav-pills" role="tablist">
                  <li class="nav-item">
                     <%--<button
                        type="button"
                        class="nav-link active"
                        role="tab"
                        data-bs-toggle="tab"
                        data-bs-target="#navs-tabs-line-card-income"
                        aria-controls="navs-tabs-line-card-income"
                        aria-selected="true"
                        >
                     Income
                     </button>--%>
                      <asp:Button ID="btnIncome" runat="server" Text="Income" CssClass="nav-link active" OnClick="btnIncome_Click"/>
                  </li>
                  <li class="nav-item">
                     <%--<button type="button" class="nav-link" role="tab">Expenses</button>--%>
                      <asp:Button ID="btnExpenses" runat="server" Text="Expenses" CssClass="nav-link" OnClick="btnExpenses_Click"/>
                  </li>
                  <li class="nav-item">
                     <%--<button type="button" class="nav-link" role="tab">Profit</button>--%>
                      <asp:Button ID="btnProfit" runat="server" Text="Profit" CssClass="nav-link" OnClick="btnProfit_Click"/>
                  </li>
               </ul>
            </div>
            <div class="card-body px-0">
               <div class="tab-content p-0">
                  <div class="tab-pane fade show active" id="navs-tabs-line-card-income" role="tabpanel">
                     <div class="d-flex p-4 pt-3">
                        <div class="avatar flex-shrink-0 me-3">
                           <img src="images/icons/unicons/wallet.png" alt="User" />
                        </div>
                        <div>
                           <small class="text-muted d-block">Total <asp:Literal ID="ltlBalanceTitle" runat="server" Text="Income"></asp:Literal></small>
                           <div class="d-flex align-items-center">
                              <h6 class="mb-0 me-1">RM <asp:Literal ID="ltlBalanceAmount" runat="server" Text="0.00"></asp:Literal></h6>
                              <small class="text-success fw-semibold">
                              <i class="bx bx-chevron-up"></i>
                              <asp:Literal ID="ltlBalancePercentage" runat="server" Text="0.0%"></asp:Literal>
                              </small>
                           </div>
                        </div>
                     </div>
                     <div id="incomeChart"></div>
                     <div class="d-flex justify-content-center pt-4 gap-2">
                        <div class="flex-shrink-0">
                           <div id="expensesOfWeek"></div>
                        </div>
                        <div>
                           <p class="mb-n1 mt-1">Expenses This Week</p>
                           <small class="text-muted">RM 39 less than last week</small>
                        </div>
                     </div>
                  </div>
               </div>
            </div>
         </div>
      </div>
      <!--/ Expense Overview -->
      <!-- Transactions -->
      <div class="col-md-6 col-lg-4 order-2 mb-4">
         <div class="card h-100">
            <div class="card-header d-flex align-items-center justify-content-between">
               <h5 class="card-title m-0 me-2">Transactions</h5>
               <div class="dropdown">
                  <button
                     class="btn p-0"
                     type="button"
                     id="transactionID"
                     data-bs-toggle="dropdown"
                     aria-haspopup="true"
                     aria-expanded="false"
                     >
                  <i class="bx bx-dots-vertical-rounded"></i>
                  </button>
                  <div class="dropdown-menu dropdown-menu-end" aria-labelledby="transactionID">
                     <a class="dropdown-item" href="javascript:void(0);">Last 28 Days</a>
                     <a class="dropdown-item" href="javascript:void(0);">Last Month</a>
                     <a class="dropdown-item" href="javascript:void(0);">Last Year</a>
                  </div>
               </div>
            </div>
            <div class="card-body">
               <ul class="p-0 m-0">
                  <li class="d-flex mb-4 pb-1">
                     <div class="avatar flex-shrink-0 me-3">
                        <img src="images/icons/unicons/paypal.png" alt="User" class="rounded" />
                     </div>
                     <div class="d-flex w-100 flex-wrap align-items-center justify-content-between gap-2">
                        <div class="me-2">
                           <small class="text-muted d-block mb-1">Ticket Payment</small>
                           <h6 class="mb-0">FPX</h6>
                        </div>
                        <div class="user-progress d-flex align-items-center gap-1">
                           <h6 class="mb-0">+<%= paymentMethodTransaction["F"].ToString("0.00") %></h6>
                           <span class="text-muted">MYR</span>
                        </div>
                     </div>
                  </li>

                  <li class="d-flex mb-4 pb-1">
                     <div class="avatar flex-shrink-0 me-3">
                        <img src="images/icons/unicons/wallet.png" alt="User" class="rounded" />
                     </div>
                     <div class="d-flex w-100 flex-wrap align-items-center justify-content-between gap-2">
                        <div class="me-2">
                           <small class="text-muted d-block mb-1">Ticket Payment</small>
                           <h6 class="mb-0">Billplz FPX</h6>
                        </div>
                        <div class="user-progress d-flex align-items-center gap-1">
                           <h6 class="mb-0">+<%= paymentMethodTransaction["B"].ToString("0.00") %></h6>
                           <span class="text-muted">MYR</span>
                        </div>
                     </div>
                  </li>

                  <li class="d-flex mb-4 pb-1">
                     <div class="avatar flex-shrink-0 me-3">
                        <img src="images/icons/unicons/chart.png" alt="User" class="rounded" />
                     </div>
                     <div class="d-flex w-100 flex-wrap align-items-center justify-content-between gap-2">
                        <div class="me-2">
                           <small class="text-muted d-block mb-1">Ticket Payment</small>
                           <h6 class="mb-0">Credit/Debit Card</h6>
                        </div>
                        <div class="user-progress d-flex align-items-center gap-1">
                           <h6 class="mb-0">+<%= paymentMethodTransaction["C"].ToString("0.00") %></h6>
                           <span class="text-muted">MYR</span>
                        </div>
                     </div>
                  </li>

                  <li class="d-flex mb-4 pb-1">
                     <div class="avatar flex-shrink-0 me-3">
                        <img src="images/icons/unicons/cc-success.png" alt="User" class="rounded" />
                     </div>
                     <div class="d-flex w-100 flex-wrap align-items-center justify-content-between gap-2">
                        <div class="me-2">
                           <small class="text-muted d-block mb-1">Ticket Payment</small>
                           <h6 class="mb-0">PayPal</h6>
                        </div>
                        <div class="user-progress d-flex align-items-center gap-1">
                           <h6 class="mb-0">+<%= paymentMethodTransaction["P"].ToString("0.00") %></h6>
                           <span class="text-muted">MYR</span>
                        </div>
                     </div>
                  </li>

                  <li class="d-flex mb-4 pb-1">
                     <div class="avatar flex-shrink-0 me-3">
                        <img src="images/icons/unicons/wallet.png" alt="User" class="rounded" />
                     </div>
                     <div class="d-flex w-100 flex-wrap align-items-center justify-content-between gap-2">
                        <div class="me-2">
                           <small class="text-muted d-block mb-1">Ticket Payment</small>
                           <h6 class="mb-0">Touch 'n Go</h6>
                        </div>
                        <div class="user-progress d-flex align-items-center gap-1">
                           <h6 class="mb-0">+<%= paymentMethodTransaction["T"].ToString("0.00") %></h6>
                           <span class="text-muted">MYR</span>
                        </div>
                     </div>
                  </li>

                  <%--<li class="d-flex">
                     <div class="avatar flex-shrink-0 me-3">
                        <img src="images/icons/unicons/cc-warning.png" alt="User" class="rounded" />
                     </div>
                     <div class="d-flex w-100 flex-wrap align-items-center justify-content-between gap-2">
                        <div class="me-2">
                           <small class="text-muted d-block mb-1">Mastercard</small>
                           <h6 class="mb-0">Ordered Equitment</h6>
                        </div>
                        <div class="user-progress d-flex align-items-center gap-1">
                           <h6 class="mb-0">-92.45</h6>
                           <span class="text-muted">MYR</span>
                        </div>
                     </div>
                  </li>--%>
               </ul>
            </div>
         </div>
      </div>
      <!--/ Transactions -->
   </div>
</div>
<!-- / Content -->


<script type="text/javascript" src="https://cdn.canvasjs.com/canvasjs.min.js"></script>
<script>
window.onload = function () {

    var chart = new CanvasJS.Chart("totalRevenueChartWithExpenses", {
	animationEnabled: true,
	title:{
		text: ""
	},
	axisY :{
		includeZero: false,
		prefix: ""
	},
	toolTip: {
		shared: true
	},
	legend: {
		fontSize: 13
	},
	data: [{
		type: "splineArea",
		showInLegend: true,
		name: "Revenue",
		yValueFormatString: "$#,##0",
        xValueFormatString: "MMM YYYY",
        color: "rgb(105, 108, 255)",
		dataPoints: [
			   
   //       	{ x: new Date(2023, 1), y: 1232 },
			//{ x: new Date(2023, 2), y: 3523 },
   //       	{ x: new Date(2023, 3), y: 1245 },
   //       	{ x: new Date(2023, 4), y: 3633 },
   //       	{ x: new Date(2023, 5), y: 5344 },
   //       	{ x: new Date(2023, 6), y: 899 },
   //       	{ x: new Date(2023, 7), y: 3423 },
          	{ x: new Date(2023, 8), y: 2356 },
          	{ x: new Date(2023, 9), y: 6784 },
          	{ x: new Date(2023, 10), y: 4333 },
          	{ x: new Date(2023, 11), y: 4441 },
          	{ x: new Date(2023, 12), y: 3444 },    
          	{ x: new Date(2024, 1), y: 5433 },   
		]
 	},
	{
		type: "splineArea", 
		showInLegend: true,
		name: "Expenses",
        yValueFormatString: "$#,##0",
        color: "rgb(3, 195, 236)",
		dataPoints: [
   //       	{ x: new Date(2023, 1), y: 200 },
			//{ x: new Date(2023, 2), y: 150 },
   //       	{ x: new Date(2023, 3), y: 200 },
   //       	{ x: new Date(2023, 4), y: 150 },
   //       	{ x: new Date(2023, 5), y:  200},
   //       	{ x: new Date(2023, 6), y:  150},
   //       	{ x: new Date(2023, 7), y:  200},
          	{ x: new Date(2023, 8), y:  150},
          	{ x: new Date(2023, 9), y:  200},
          	{ x: new Date(2023, 10), y: 150},
          	{ x: new Date(2023, 11), y: 200},
          	{ x: new Date(2023, 12), y: 150},    
          	{ x: new Date(2024, 1), y: 200 },   
		]
 	},
	]
});
chart.render();

}
</script>


</asp:Content>
