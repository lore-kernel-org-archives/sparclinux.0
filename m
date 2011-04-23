From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 23 Apr 2011 11:02:54 +0000
Subject: Re: [PATCH 1/3] sparc32: always define boot_cpu_id
Message-Id: <20110423110254.GA18446@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1303395625-6911-1-git-send-email-daniel@gaisler.com>
In-Reply-To: <1303395625-6911-1-git-send-email-daniel@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Thu, Apr 21, 2011 at 04:20:23PM +0200, Daniel Hellstrom wrote:
> Define boot_cpu_id in single-processor kernels as well. This is
> to support architectures which can boot on other than CPU0.
> 
> Sam Ravnborg has written the cleanup parts by extracting
> boot_cpu_id from smp_32.c into setup_32.c and cleaned up
> sun4d_irq.c.
> 
> boot_cpu_id was initialized before BSS was cleared in
> sun4c_continue_boot, instead boot_cpu_id is set to 0xff to
> avoid BSS. If boot_cpu_id is untouched (0xff) by bootup code
> it will be overwritten to 0. boot_cpu_id4 is automatically
> calculated in common code.
> 
> Signed-off-by: Daniel Hellstrom <daniel@gaisler.com>
Acked-by: Sam Ravnborg <sam@ravnborg.org>
