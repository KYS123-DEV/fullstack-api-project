import { Controller, Get } from '@nestjs/common';
import { MenusService } from './menus.service';

@Controller('menus')
export class MenusController {
  constructor(private readonly menuService: MenusService) {}
  
  //메뉴 반환 요청
  @Get()
  async getMenus() {
    return await this.menuService.getSidebarMenus();
  }
}