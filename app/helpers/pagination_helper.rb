module PaginationHelper
  def paginate_collection(collection, page, per_page)
    result = collection.page(page).per(per_page)
    result = collection.page(result.total_pages).per(per_page) if result.empty?
    result
  end
end
