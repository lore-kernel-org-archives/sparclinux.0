From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 29 Nov 2008 22:05:51 +0000
Subject: [PATCH 07/10] sparc: gitignore a few files
Message-Id: <1227996354-11478-7-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

With this 'git status' no longer reports any new files
At least not for a sparc allnoconfig build

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/boot/.gitignore   |    5 +++++
 arch/sparc/kernel/.gitignore |    1 +
 2 files changed, 6 insertions(+), 0 deletions(-)
 create mode 100644 arch/sparc/boot/.gitignore
 create mode 100644 arch/sparc/kernel/.gitignore

diff --git a/arch/sparc/boot/.gitignore b/arch/sparc/boot/.gitignore
new file mode 100644
index 0000000..8ffba57
--- /dev/null
+++ b/arch/sparc/boot/.gitignore
@@ -0,0 +1,5 @@
+btfix.S
+btfixupprep
+image
+zImage
+
diff --git a/arch/sparc/kernel/.gitignore b/arch/sparc/kernel/.gitignore
new file mode 100644
index 0000000..c5f676c
--- /dev/null
+++ b/arch/sparc/kernel/.gitignore
@@ -0,0 +1 @@
+vmlinux.lds
-- 
1.5.6.GIT

