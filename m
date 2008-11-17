From: Sam Ravnborg <sam@ravnborg.org>
Date: Mon, 17 Nov 2008 22:06:05 +0000
Subject: [PATCH 6/6] sparc: ignore vmlinux.lds
Message-Id: <1226959565-14796-6-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/kernel/.gitignore |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)
 create mode 100644 arch/sparc/kernel/.gitignore

diff --git a/arch/sparc/kernel/.gitignore b/arch/sparc/kernel/.gitignore
new file mode 100644
index 0000000..c5f676c
--- /dev/null
+++ b/arch/sparc/kernel/.gitignore
@@ -0,0 +1 @@
+vmlinux.lds
-- 
1.5.6.GIT

