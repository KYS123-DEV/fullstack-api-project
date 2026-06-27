import { Injectable, Inject } from '@nestjs/common';
import { SupabaseClient } from '@supabase/supabase-js';

@Injectable()
export class MenusService {
  // 모듈이 켜질 때 미리 연동해둔 'SUPABASE_CLIENT' 부품을 생성자를 통해 자동으로 주입.
  constructor(
    @Inject('SUPABASE_CLIENT') private readonly supabase: SupabaseClient,
  ) {}

  async getSidebarMenus() {
    // 이제 이미 완벽하게 연동된 supabase 객체를 그냥 마음껏 찌르면 됩니다.
    const { data, error } = await this.supabase
      .from('sidebar_menus')
      .select()
      .order('parent_id', { ascending: true })
      .order('sort_order', { ascending: true });

    if (error) {
      throw new Error(`[NestJS DB 에러] 메뉴 조회 실패: ${error.message}`);
    }

    return data;
  }
}