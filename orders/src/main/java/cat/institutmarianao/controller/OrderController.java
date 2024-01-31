package cat.institutmarianao.controller;

import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.servlet.ModelAndView;

import cat.institutmarianao.domain.Item;
import cat.institutmarianao.domain.Order;
import cat.institutmarianao.domain.User;
import cat.institutmarianao.service.ItemDetailsService;
import cat.institutmarianao.service.OrderDetailsService;

// - Configure Spring element and add mappings
@Controller
@RequestMapping(value = "/users/orders")
@SessionAttributes({ "order" })
public class OrderController {

	@Autowired
	private UserDetailsService userDetailsService;

	@Autowired
	private ItemDetailsService itemDetailsService;

	@Autowired
	private OrderDetailsService orderDetailsService;

	@ModelAttribute("order")
	public Order setupOrder() {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		String username = authentication.getName();
		User client = (User) userDetailsService.loadUserByUsername(username);

		Order order = new Order();
		order.setClient(client);
		return order;
	}

	@GetMapping
	public ModelAndView orders() {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		String username = authentication.getName();
		// - get authenticated user here
		User client = (User) userDetailsService.loadUserByUsername(username);
		// - get user orders
		List<String> orderStates = Arrays.asList(Order.STATES);
		Set<Order> userOrders = orderDetailsService.findByUser(client);
		// - Prepare the orders.jsp view and send user orders and Order.STATES as
		// parameter
		ModelAndView modelAndView = new ModelAndView("orders");
		modelAndView.getModelMap().addAttribute("orders", userOrders);
		modelAndView.getModelMap().addAttribute("orderStates", orderStates);
		return modelAndView;
	}

	@GetMapping(value = "/newOrder")
	public ModelAndView newOrder() {
		// - Prepare the newOrder.jsp view and send all the available items
		// - The new user order is in session
		ModelAndView modelAndView = new ModelAndView("newOrder");
		List<Item> items = itemDetailsService.getAll();
		modelAndView.getModelMap().addAttribute("items", items);

		return modelAndView;
	}

	public String newOrderClearItems(@SessionAttribute("order") Order order) {

		order.clearItems();

		return "redirect:/users/orders/newOrder";
	}

	@GetMapping(value = "/newOrder/increaseItem")
	public String newOrderIncreaseItem(@SessionAttribute("order") Order order,
			@RequestParam(name = "reference") String reference) {
		/* - Get the reference parameter */
		Item item = itemDetailsService.get(reference);
		order.increaseQuantity(item);
		// - Get the item related to the reference passed as parameter
		// - Increase item quantity
		return "redirect:/users/orders/newOrder";
	}

	@GetMapping(value = "/newOrder/decreaseItem")
	public String newOrderDecreaseItem(@SessionAttribute("order") Order order,
			@RequestParam(name = "reference") String reference) {
		/* - Get the reference parameter */
		Item item = itemDetailsService.get(reference);
		order.decreaseQuantity(item);
		// - Get the item related to the reference passed as parameter
		// - Decrease item quantity

		return "redirect:/users/orders/newOrder";
	}

	@GetMapping(value = "/newOrder/finishOrder")
	public String finishOrder() {
		return "finishOrder";
	}

	@InitBinder
	public void initialiseBinder(WebDataBinder binder) {
	}

	@PostMapping(value = "/newOrder/finishOrder")
	public String finishOrder(@ModelAttribute("order") Order order,
			/* - Get the order submitted in form and validate it */ BindingResult bindingResult,
			SessionStatus sessionStatus) {

		if (bindingResult.hasErrors()) {
			return "finishOrder";
		}
		order.setReference(Order.incReferenceSequence());
		// - Set a new reference for the order using Order.incReferenceSequence()
		order.setStartDate(new Date());
		// - Set order start date to current date
		// - Save order
		orderDetailsService.save(order);
		sessionStatus.setComplete(); // Clean session attributes - leave a new order ready in session

		return "redirect:/users/orders";
	}
}
