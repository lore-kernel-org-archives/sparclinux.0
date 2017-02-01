From: David Miller <davem@davemloft.net>
Date: Wed, 01 Feb 2017 19:50:31 +0000
Subject: Re: [PATCH v3 0/4] sparc64: Jump to boot prom from console on panic
Message-Id: <20170201.145031.295104986575080480.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1485977680-203775-1-git-send-email-vijay.ac.kumar@oracle.com>
In-Reply-To: <1485977680-203775-1-git-send-email-vijay.ac.kumar@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: vijay.ac.kumar@oracle.com
Cc: sparclinux@vger.kernel.org, karl.volz@oracle.com, rob.gardner@oracle.com, linux-kernel@vger.kernel.org

From: Vijay Kumar <vijay.ac.kumar@oracle.com>
Date: Wed,  1 Feb 2017 11:34:36 -0800

> Currently Stop-A (L1A) does not make the kernel switch to OBP on panic.

This is intentional, the kernel prints a message telling the user to
press break (L1-A) if they want to drop out of the kernel and we force
the break to be allowed by setting stop_a_enabled.

I'm wondering why there is so much effort being directed into BRK
behavior.

If you want to break into the OK prompt, have the reboot-cmd
environment variable set appropriately, and simply hit BRK and it will
work in both ldom and non-ldom environments.
