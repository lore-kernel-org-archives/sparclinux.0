From: "Michael S. Tsirkin" <mst@redhat.com>
Date: Thu, 25 Dec 2014 09:30:22 +0000
Subject: [PATCH repost 15/16] sparc/uaccess: fix sparse errors
Message-Id: <1419499661-8566-16-git-send-email-mst@redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1419499661-8566-1-git-send-email-mst@redhat.com>
In-Reply-To: <1419499661-8566-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Sam Ravnborg <sam@ravnborg.org>, Dave Kleikamp <dave.kleikamp@oracle.com>, sparclinux@vger.kernel.org

virtio wants to read bitwise types from userspace using get_user.  At the
moment this triggers sparse errors, since the value is passed through an
integer.

Fix that up using __force.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 arch/sparc/include/asm/uaccess_64.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/include/asm/uaccess_64.h b/arch/sparc/include/asm/uaccess_64.h
index c990a5e..b80866d 100644
--- a/arch/sparc/include/asm/uaccess_64.h
+++ b/arch/sparc/include/asm/uaccess_64.h
@@ -145,7 +145,7 @@ case 2: __get_user_asm(__gu_val,uh,addr,__gu_ret); break; \
 case 4: __get_user_asm(__gu_val,uw,addr,__gu_ret); break; \
 case 8: __get_user_asm(__gu_val,x,addr,__gu_ret); break; \
 default: __gu_val = 0; __gu_ret = __get_user_bad(); break; \
-} data = (type) __gu_val; __gu_ret; })
+} data = (__force type) __gu_val; __gu_ret; })
 
 #define __get_user_nocheck_ret(data,addr,size,type,retval) ({ \
 register unsigned long __gu_val __asm__ ("l1"); \
@@ -155,7 +155,7 @@ case 2: __get_user_asm_ret(__gu_val,uh,addr,retval); break; \
 case 4: __get_user_asm_ret(__gu_val,uw,addr,retval); break; \
 case 8: __get_user_asm_ret(__gu_val,x,addr,retval); break; \
 default: if (__get_user_bad()) return retval; \
-} data = (type) __gu_val; })
+} data = (__force type) __gu_val; })
 
 #define __get_user_asm(x,size,addr,ret)					\
 __asm__ __volatile__(							\
-- 
MST

