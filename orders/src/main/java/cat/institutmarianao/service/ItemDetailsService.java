package cat.institutmarianao.service;

import java.util.List;

import cat.institutmarianao.domain.Item;

public interface ItemDetailsService {

	public List<Item> getAll();

	public Item get(String reference);

}
