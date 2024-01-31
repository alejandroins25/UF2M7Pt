package cat.institutmarianao.domain;

import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.Pattern;

public class Address {

	@NotEmpty(message = "El nombre del destinatario no puede estar vacío")
	private String recipientName;

	@NotEmpty(message = "La dirección no puede estar vacía")
	private String address;

	@Pattern(regexp = "\\d{5}", message = "El código postal debe tener 5 dígitos")
	private String zipCode;

	@NotEmpty(message = "La ciudad no puede estar vacía")
	private String city;

	@NotEmpty(message = "El estado no puede estar vacío")
	private String state;

	@NotEmpty(message = "El país no puede estar vacío")
	private String country;

	public String getRecipientName() {
		return recipientName;
	}

	public void setRecipientName(String recipientName) {
		this.recipientName = recipientName;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getZipCode() {
		return zipCode;
	}

	public void setZipCode(String zipCode) {
		this.zipCode = zipCode;
	}

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public String getCountry() {
		return country;
	}

	public void setCountry(String country) {
		this.country = country;
	}
}
