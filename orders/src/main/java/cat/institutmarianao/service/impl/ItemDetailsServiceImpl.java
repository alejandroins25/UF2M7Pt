package cat.institutmarianao.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cat.institutmarianao.domain.Item;
import cat.institutmarianao.repository.ItemRepository;
import cat.institutmarianao.service.ItemDetailsService;

@Service
public class ItemDetailsServiceImpl implements ItemDetailsService {

	@Autowired
	private ItemRepository itemRepository;

	@Override
	public List<Item> getAll() {
		return itemRepository.getAll();
	}

	@Override
	public Item get(String reference) {
		return itemRepository.get(reference);
	}

}
