from django.contrib import admin

from .models import Category, Product, ProductImage, ProductReview

@admin.register(Category)
class CategoryAdmin(admin.ModelAdmin):
    prepopulated_fields = {'slug': ('title', )}
    list_display = ('title', 'slug')


@admin.register(Product)
class ProductAdmin(admin.ModelAdmin):
    prepopulated_fields = {'slug': ('title', )}
    list_display = ('title', 'category', 'price', 'parent', 'date_added', 'last_visit')
    search_fields = ['title', 'slug', 'description']

admin.site.register(ProductImage)

@admin.register(ProductReview)
class ProductReviewAdmin(admin.ModelAdmin):
    list_display = ('product', 'user', 'stars', 'date_added')