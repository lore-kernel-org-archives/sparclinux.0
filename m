From: Vijay Kumar <vijay.ac.kumar@oracle.com>
Date: Wed, 01 Feb 2017 19:34:40 +0000
Subject: [PATCH v3 4/4] Documentation/sparc: Steps for sending break on sunhv console
Message-Id: <1485977680-203775-5-git-send-email-vijay.ac.kumar@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1485977680-203775-1-git-send-email-vijay.ac.kumar@oracle.com>
In-Reply-To: <1485977680-203775-1-git-send-email-vijay.ac.kumar@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: davem@davemloft.net
Cc: sparclinux@vger.kernel.org, karl.volz@oracle.com, rob.gardner@oracle.com, linux-kernel@vger.kernel.org, vijay.ac.kumar@oracle.com

Documented the steps for sending break on sunhv console.

Signed-off-by: Vijay Kumar <vijay.ac.kumar@oracle.com>
---
 Documentation/sparc/console.txt |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/Documentation/sparc/console.txt b/Documentation/sparc/console.txt
new file mode 100644
index 0000000..5aa735a
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

