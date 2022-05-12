Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2863C433EF
	for <sparclinux@archiver.kernel.org>; Thu, 12 May 2022 10:23:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348349AbiELKXO convert rfc822-to-8bit (ORCPT
        <rfc822;sparclinux@archiver.kernel.org>);
        Thu, 12 May 2022 06:23:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242164AbiELKXM (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Thu, 12 May 2022 06:23:12 -0400
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B4976B671
        for <sparclinux@vger.kernel.org>; Thu, 12 May 2022 03:23:10 -0700 (PDT)
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.95)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1np5yO-001F9o-8w; Thu, 12 May 2022 12:23:08 +0200
Received: from p57bd9f81.dip0.t-ipconnect.de ([87.189.159.129] helo=[192.168.178.81])
          by inpost2.zedat.fu-berlin.de (Exim 4.95)
          with esmtpsa (TLS1.3)
          tls TLS_AES_128_GCM_SHA256
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1np5yB-002Lz4-HS; Thu, 12 May 2022 12:23:08 +0200
Message-ID: <596c7c03-f49a-ddab-417e-c88b1ce0dfef@physik.fu-berlin.de>
Date:   Thu, 12 May 2022 12:22:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Content-Language: en-US
To:     Sparc kernel list <sparclinux@vger.kernel.org>
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Subject: newfstatat available on sparc64?
Cc:     debian-sparc <debian-sparc@lists.debian.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 87.189.159.129
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

Hi!

LLVM has been failing to build on sparc64 for some weeks with the following error
which indicates that the syscall newfstatat is not available on sparc64 (see below).

Looking at [1] it seems to be missing. Can it be wired up?

Adrian

> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/sparc/kernel/syscalls/syscall.tbl

FAILED: projects/compiler-rt/lib/sanitizer_common/CMakeFiles/RTSanitizerCommonNoHooks.sparcv9.dir/sanitizer_linux.cpp.o 
/usr/bin/c++ -DHAVE_RPC_XDR_H=0 -D_DEBUG -D_GNU_SOURCE -D__STDC_CONSTANT_MACROS -D__STDC_FORMAT_MACROS -D__STDC_LIMIT_MACROS -I/var/lib/buildbot/workers/debian-stadler-sparc64/clang-sparc64-linux-multistage/stage1/projects/compiler-rt/lib/sanitizer_common -I/var/lib/buildbot/workers/debian-stadler-sparc64/clang-sparc64-linux-multistage/llvm/compiler-rt/lib/sanitizer_common -I/var/lib/buildbot/workers/debian-stadler-sparc64/clang-sparc64-linux-multistage/stage1/include -I/var/lib/buildbot/workers/debian-stadler-sparc64/clang-sparc64-linux-multistage/llvm/llvm/include -I/var/lib/buildbot/workers/debian-stadler-sparc64/clang-sparc64-linux-multistage/llvm/compiler-rt/lib/sanitizer_common/.. -fPIC -fno-semantic-interposition -fvisibility-inlines-hidden -Werror=date-time -Wall -Wextra -Wno-unused-parameter -Wwrite-strings -Wcast-qual -Wno-missing-field-initializers -pedantic -Wno-long-long -Wimplicit-fallthrough -Wno-maybe-uninitialized -Wno-class-memaccess -Wno-redundant-move -Wno-pessimizing-move -Wno-noexcept-type -Wdelete-non-virtual-dtor -Wsuggest-override -Wno-comment -Wmisleading-indentation -fdiagnostics-color -ffunction-sections -fdata-sections -Wall -std=c++14 -Wno-unused-parameter -O3 -DNDEBUG  -m64 -fPIC -fno-builtin -fno-exceptions -fomit-frame-pointer -funwind-tables -fno-stack-protector -fvisibility=hidden -fno-lto -O3 -g -Wno-variadic-macros -nostdinc++ -Wno-format -fno-rtti -Wframe-larger-than=570 -DSANITIZER_SUPPORTS_WEAK_HOOKS=0 -UNDEBUG -std=c++14 -MD -MT projects/compiler-rt/lib/sanitizer_common/CMakeFiles/RTSanitizerCommonNoHooks.sparcv9.dir/sanitizer_linux.cpp.o -MF projects/compiler-rt/lib/sanitizer_common/CMakeFiles/RTSanitizerCommonNoHooks.sparcv9.dir/sanitizer_linux.cpp.o.d -o projects/compiler-rt/lib/sanitizer_common/CMakeFiles/RTSanitizerCommonNoHooks.sparcv9.dir/sanitizer_linux.cpp.o -c /var/lib/buildbot/workers/debian-stadler-sparc64/clang-sparc64-linux-multistage/llvm/compiler-rt/lib/sanitizer_common/sanitizer_linux.cpp
In file included from /var/lib/buildbot/workers/debian-stadler-sparc64/clang-sparc64-linux-multistage/llvm/compiler-rt/lib/sanitizer_common/sanitizer_linux.cpp:191:
/var/lib/buildbot/workers/debian-stadler-sparc64/clang-sparc64-linux-multistage/llvm/compiler-rt/lib/sanitizer_common/sanitizer_linux.cpp: In function ‘__sanitizer::uptr __sanitizer::internal_stat(const char*, void*)’:
/var/lib/buildbot/workers/debian-stadler-sparc64/clang-sparc64-linux-multistage/llvm/compiler-rt/lib/sanitizer_common/sanitizer_syscall_generic.inc:19:24: error: ‘__NR_newfstatat’ was not declared in this scope
   19 | # define SYSCALL(name) __NR_ ## name
      |                        ^~~~~
/var/lib/buildbot/workers/debian-stadler-sparc64/clang-sparc64-linux-multistage/llvm/compiler-rt/lib/sanitizer_common/sanitizer_linux.cpp:347:27: note: in expansion of macro ‘SYSCALL’
  347 |   return internal_syscall(SYSCALL(newfstatat), AT_FDCWD, (uptr)path, (uptr)buf,
      |                           ^~~~~~~
/var/lib/buildbot/workers/debian-stadler-sparc64/clang-sparc64-linux-multistage/llvm/compiler-rt/lib/sanitizer_common/sanitizer_linux.cpp: In function ‘__sanitizer::uptr __sanitizer::internal_lstat(const char*, void*)’:
/var/lib/buildbot/workers/debian-stadler-sparc64/clang-sparc64-linux-multistage/llvm/compiler-rt/lib/sanitizer_common/sanitizer_syscall_generic.inc:19:24: error: ‘__NR_newfstatat’ was not declared in this scope
   19 | # define SYSCALL(name) __NR_ ## name
      |                        ^~~~~
/var/lib/buildbot/workers/debian-stadler-sparc64/clang-sparc64-linux-multistage/llvm/compiler-rt/lib/sanitizer_common/sanitizer_linux.cpp:370:27: note: in expansion of macro ‘SYSCALL’
  370 |   return internal_syscall(SYSCALL(newfstatat), AT_FDCWD, (uptr)path, (uptr)buf,
      |                           ^~~~~~~
/var/lib/buildbot/workers/debian-stadler-sparc64/clang-sparc64-linux-multistage/llvm/compiler-rt/lib/sanitizer_common/sanitizer_linux.cpp: In member function ‘__sanitizer::SignalContext::WriteFlag __sanitizer::SignalContext::GetWriteFlag() const’:
/var/lib/buildbot/workers/debian-stadler-sparc64/clang-sparc64-linux-multistage/llvm/compiler-rt/lib/sanitizer_common/sanitizer_linux.cpp:1818:12: warning: unused variable ‘ucontext’ [-Wunused-variable]
 1818 |   Context *ucontext = (Context *)context;
      |            ^~~~~~~~


-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
