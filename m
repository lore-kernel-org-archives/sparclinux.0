From: Bob Breuer <breuerr@mc.net>
Date: Fri, 14 Jan 2005 04:24:50 +0000
Subject: dump_stack missing on sparc32
Message-Id: <41E74992.9060609@mc.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20050114041906.GE6101@holomorphy.com>
In-Reply-To: <20050114041906.GE6101@holomorphy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

The sparc32 specific dump_stack function is missing, but there is a 
show_stack in arch/sparc/kernel/process.c.  Should it be easy enough to 
connect these together, or are there known bugs that prevent the use of 
dump_stack?

Bob
