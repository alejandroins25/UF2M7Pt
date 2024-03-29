package cat.institutmarianao.domain;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import jakarta.validation.constraints.Future;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;

public class Order {
	public static final String[] STATES = { "order.state.pending", "order.state.transit", "order.state.delivery",
			"order.state.absent", "order.state.pending.collection", "order.state.returned" };

	private static int referenceSequence = 1;

	@NotNull
	private Integer reference;

	@NotNull
	private User client;

	@NotNull
	private Address deliveryAddress = new Address();

	@NotNull
	@Size(min = 1, message = "Debe haber al menos un ítem en la orden")
	private Map<Item, Integer> items = new HashMap<>();

	@NotNull
	private Date startDate;

	@Future
	private Date deliveryDate;

	@Min(value = 0, message = "El estado debe ser como mínimo 0")
	private Integer state = 0;

	@Min(value = 0, message = "La cantidad total debe ser como mínimo 0")
	private Integer totalQuantity = 0;

	@Min(value = 0, message = "El monto total debe ser como mínimo 0")
	private Double totalAmount = 0d;

	public static int incReferenceSequence() {
		return referenceSequence++;
	}

	public int getReference() {
		return reference;
	}

	public void setReference(int reference) {
		this.reference = reference;
	}

	public User getClient() {
		return client;
	}

	public void setClient(User client) {
		this.client = client;
	}

	public Address getDeliveryAddress() {
		return deliveryAddress;
	}

	public void setDeliveryAddress(Address deliveryAddress) {
		this.deliveryAddress = deliveryAddress;
	}

	public Map<Item, Integer> getItems() {
		return items;
	}

	public void increaseQuantity(Item item) {
		Integer quantity = items.containsKey(item) ? items.get(item) : 0;
		items.put(item, quantity + 1);
		totalQuantity++;
		totalAmount += item.getPrice();
	}

	public void decreaseQuantity(Item item) {
		Integer quantity = items.containsKey(item) ? items.get(item) : 0;
		if (quantity <= 1) {
			items.remove(item);
		} else {
			items.put(item, quantity - 1);
		}
		totalQuantity--;
		totalAmount -= item.getPrice();
	}

	public void setItems(Map<Item, Integer> items) {
		this.items = items;
	}

	public void clearItems() {
		items.clear();
	}

	public Date getStartDate() {
		return startDate;
	}

	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}

	public Date getDeliveryDate() {
		return deliveryDate;
	}

	public void setDeliveryDate(Date deliveryDate) {
		this.deliveryDate = deliveryDate;
	}

	public int getState() {
		return state;
	}

	public void setState(Integer state) {
		this.state = state;
	}

	public Integer getTotalQuantity() {
		return totalQuantity;
	}

	public Double getTotalAmount() {
		return totalAmount;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + (reference == null ? 0 : reference.hashCode());
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj) {
			return true;
		}
		if (obj == null) {
			return false;
		}
		if (getClass() != obj.getClass()) {
			return false;
		}
		Order other = (Order) obj;
		if (reference == null) {
			if (other.reference != null) {
				return false;
			}
		} else if (!reference.equals(other.reference)) {
			return false;
		}
		return true;
	}

}
