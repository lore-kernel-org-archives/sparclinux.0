From: Vijay Kumar <vijay.ac.kumar@oracle.com>
Date: Thu, 10 Nov 2016 22:43:36 +0000
Subject: [PATCH 4/4] Documentation/sparc: Steps for sending break on sunhv console
Message-Id: <1478817816-98939-4-git-send-email-vijay.ac.kumar@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1478817816-98939-1-git-send-email-vijay.ac.kumar@oracle.com>
In-Reply-To: <1478817816-98939-1-git-send-email-vijay.ac.kumar@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: davem@davemloft.net, sparclinux@vger.kernel.org
Cc: karl.volz@oracle.com, rob.gardner@oracle.com, linux-kernel@vger.kernel.org

Documented the steps for sending break on sunhv console.

Signed-off-by: Vijay Kumar <vijay.ac.kumar@oracle.com>
---
 Documentation/sparc/console.txt |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/Documentation/sparc/console.txt b/Documentation/sparc/console.txt
new file mode 100644
index 0000000..ab55353
--- /dev/null
+++ b/Documentation/sparc/console.txt
@@ -0,0 +1,9 @@
+Steps for sending 'break' on sunhv console:
+=====================+
+On Baremetal:
+   1. press   Esc + 'B'
+
+On LDOM:
+   1. press    Ctrl + ']'
+   2. telnet> send  break	
-- 
1.7.1

