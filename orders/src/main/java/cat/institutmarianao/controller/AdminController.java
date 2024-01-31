package cat.institutmarianao.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import cat.institutmarianao.domain.Order;
import cat.institutmarianao.service.OrderDetailsService;
import jakarta.servlet.ServletException;

//- Configure Spring element and add mappings
@Controller
@RequestMapping(value = "admin/orders")
public class AdminController {

	@Autowired
	private OrderDetailsService orderDetailsService;

	@GetMapping
	public ModelAndView orders() {
		// - get all orders
		// - Prepare the orders.jsp view and send user orders and Order.STATES as
		// STATES parameter
		List<String> orderStates = Arrays.asList(Order.STATES);

		ModelAndView modelAndView = new ModelAndView("orders");
		modelAndView.getModelMap().addAttribute("orders", orderDetailsService.getAll());
		modelAndView.getModelMap().addAttribute("orderStates", orderStates);
		return modelAndView;
	}

	@PostMapping(value = "/setDeliveryDate")
	public String setDeliveryDate(/* - Get reference parameter */ @RequestParam("reference") String reference,
			/* - Get deliveryDate parameter */ @RequestParam("deliveryDate") String deliveryDate)
			throws ServletException {
		// - Get the order related to the reference passed as parameter
		Order order = orderDetailsService.getByReference(Integer.parseInt(reference));
		if (order == null) {
			throw new ServletException("Order with reference=" + reference + " not found ");
		}
		try {
			// - Set the order delivery date with the deliveryDate value
			order.setDeliveryDate(new SimpleDateFormat("yyyy-MM-dd").parse(deliveryDate));
		} catch (ParseException e) {
			throw new ServletException(e);
		}
		orderDetailsService.save(order);
		// - Save the order
		return "redirect:/admin/orders";
	}

	@PostMapping(value = "/setState")
	public String setState(/* - Get reference parameter */ @RequestParam("reference") String reference,
			/* - Get state parameter */ @RequestParam("state") Integer STATE) throws ServletException {
		Order order = orderDetailsService.getByReference(Integer.parseInt(reference));
		// - Get the order related to the reference passed as parameter
		if (order == null) {
			throw new ServletException("Order with reference=" + reference + " not found ");
		}
		// - Set the order state with the state value
		order.setState(STATE);
		orderDetailsService.save(order);
		// - Save the order
		return "redirect:/admin/orders";
	}
}
