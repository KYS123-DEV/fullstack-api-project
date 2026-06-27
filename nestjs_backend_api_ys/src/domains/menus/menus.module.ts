import { Module } from '@nestjs/common';
import { MenusController } from './menus.controller';
import { MenusService } from './menus.service';
import { createClient } from '@supabase/supabase-js';

@Module({
  controllers: [MenusController],
  providers: [
    MenusService,
    // 서버가 켜질 때 DB 연동 함수를 호출하여 고유 토큰('SUPABASE_CLIENT')으로 등록
    {
      provide: 'SUPABASE_CLIENT',
      useFactory: () => {
        // 서버 구동 시 딱 한 번만 실행되어 연동.
        return createClient(
          process.env.SUPABASE_URL || '',
          process.env.SUPABASE_ANON_KEY || ''
        );
      },
    },
  ],
  // 다른 모듈에서도 이 Supabase 연동 객체를 쓰고 싶다면 export 해줍니다.
  exports: ['SUPABASE_CLIENT'], 
})
export class MenusModule {}