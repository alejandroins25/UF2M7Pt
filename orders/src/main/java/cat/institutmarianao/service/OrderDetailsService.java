package cat.institutmarianao.service;

import java.util.Set;

import cat.institutmarianao.domain.Order;
import cat.institutmarianao.domain.User;

public interface OrderDetailsService {

	Set<Order> getAll();

	Order getByReference(Integer reference);

	Set<Order> findByUser(User client);

	public void save(Order order);

}
