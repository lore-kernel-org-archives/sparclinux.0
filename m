From: David Miller <davem@davemloft.net>
Date: Mon, 14 May 2012 21:22:12 +0000
Subject: Re: [PATCH] sparc32: move smp ipi to method ops
Message-Id: <20120514.172212.1091627683366665215.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20120514150745.GA28682@merkur.ravnborg.org>
In-Reply-To: <20120514150745.GA28682@merkur.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Mon, 14 May 2012 17:07:45 +0200

>>From c940e0c5f1491b5c8a24c97256eea78d20484875 Mon Sep 17 00:00:00 2001
> From: Sam Ravnborg <sam@ravnborg.org>
> Date: Mon, 14 May 2012 15:14:36 +0200
> Subject: [PATCH] sparc32: move smp ipi to method ops
> 
> I ended up renaming set_cpu_int to send_ipi to
> be consistent all way around.
> send_ipi was moved to the *_smp.c files so
> we could call the relevant method direct,
> without any _ops indirection.
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

Applied.
