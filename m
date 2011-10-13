From: Konrad Eisele <konrad@gaisler.com>
Date: Thu, 13 Oct 2011 07:00:01 +0000
Subject: [PATCH 0/4] introduction
Message-Id: <1318489205-315-1-git-send-email-konrad@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1318335487-25506-1-git-send-email-konrad@gaisler.com>
In-Reply-To: <1318335487-25506-1-git-send-email-konrad@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

[PATCH 1/4] apbuart: add polling callbacks to apbuart driver:
   adds polling functions to apbuart.c

[PATCH 2/4] apbuart: add support for virtual KGDB<->GRMON channel   
   add GRMON virtual channel for KGDB

[PATCH 3/4] sparc32: return destination pointer on return from memcpy   
    fix memcpy to return destination pointer

[PATCH 4/4] sparc32: Add support for KGDB with SMP for leon and sun4d
    Implement KGDB for SMP for Leon and sun4d. For sun4m smp4m_ipi_kgdbcapture is a
    stub that has to be implemented later.
 
Greetings Konrad


