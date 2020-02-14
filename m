From: Sasha Levin <sashal@kernel.org>
Date: Fri, 14 Feb 2020 16:19:18 +0000
Subject: [PATCH AUTOSEL 4.9 018/141] sparc: Add .exit.data section.
Message-Id: <20200214162122.19794-18-sashal@kernel.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20200214162122.19794-1-sashal@kernel.org>
In-Reply-To: <20200214162122.19794-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, Sasha Levin <sashal@kernel.org>, sparclinux@vger.kernel.org

From: "David S. Miller" <davem@davemloft.net>

[ Upstream commit 548f0b9a5f4cffa0cecf62eb12aa8db682e4eee6 ]

This fixes build errors of all sorts.

Also, emit .exit.text unconditionally.

Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/sparc/kernel/vmlinux.lds.S | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/kernel/vmlinux.lds.S b/arch/sparc/kernel/vmlinux.lds.S
index 572db686f8458..385d6d04564d5 100644
--- a/arch/sparc/kernel/vmlinux.lds.S
+++ b/arch/sparc/kernel/vmlinux.lds.S
@@ -151,12 +151,14 @@ SECTIONS
 	}
 	PERCPU_SECTION(SMP_CACHE_BYTES)
 
-#ifdef CONFIG_JUMP_LABEL
 	. = ALIGN(PAGE_SIZE);
 	.exit.text : {
 		EXIT_TEXT
 	}
-#endif
+
+	.exit.data : {
+		EXIT_DATA
+	}
 
 	. = ALIGN(PAGE_SIZE);
 	__init_end = .;
-- 
2.20.1
