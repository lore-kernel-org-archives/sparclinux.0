From: David Miller <davem@davemloft.net>
Date: Sun, 20 May 2012 20:39:33 +0000
Subject: Re: [PATCH 1/2] sparc32: fix cpuid_patch run-time patching
Message-Id: <20120520.163933.122907259597206889.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20120520153140.GA13857@merkur.ravnborg.org>
In-Reply-To: <20120520153140.GA13857@merkur.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 20 May 2012 17:31:40 +0200

>>From eecbbe31067e738d4342dee9709f14086cd4fbad Mon Sep 17 00:00:00 2001
> From: Sam Ravnborg <sam@ravnborg.org>
> Date: Sun, 20 May 2012 17:24:20 +0200
> Subject: [PATCH 1/2] sparc32: fix cpuid_patch run-time patching
> 
> We hang forever when trying to do run-time patching of instructions
> identified by the cpuid_patch section
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

Yikes, good catch, applied.
