From: Kristoffer Glembo <kristoffer@gaisler.com>
Date: Fri, 13 Nov 2009 15:21:22 +0000
Subject: [PATCH] No auxio on LEON
Message-Id: <1258125682-26020-1-git-send-email-kristoffer@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
References: <4AFD65B1.7070300@gaisler.com>
In-Reply-To: <4AFD65B1.7070300@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Resending this again because my mail client was not correctly configured:

Do not probe for auxio register on SPARC LEON.

(with proper emacs settings this time, thanks Josip)

Signed-off-by: Kristoffer Glembo <kristoffer@gaisler.com> 
---
 arch/sparc/kernel/auxio_32.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/sparc/kernel/auxio_32.c b/arch/sparc/kernel/auxio_32.c
index 45c4123..ee8d214 100644
--- a/arch/sparc/kernel/auxio_32.c
+++ b/arch/sparc/kernel/auxio_32.c
@@ -28,6 +28,7 @@ void __init auxio_probe(void)
 	struct resource r;
 
 	switch (sparc_cpu_model) {
+	case sparc_leon:
 	case sun4d:
 	case sun4:
 		return;
-- 
1.5.2.2

