From: David Miller <davem@davemloft.net>
Date: Tue, 21 Jan 2020 12:28:45 +0000
Subject: Re: [PATCH RESEND] sparc/console: kill off obsolete declarations
Message-Id: <20200121.132845.2048607059303572209.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20200115160749.GA3951901@rani.riverdale.lan>
In-Reply-To: <20200115160749.GA3951901@rani.riverdale.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: nivedita@alum.mit.edu
Cc: gregkh@linuxfoundation.org, jslaby@suse.com, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

From: Arvind Sankar <nivedita@alum.mit.edu>
Date: Wed, 15 Jan 2020 11:07:50 -0500

> commit 09d3f3f0e02c ("sparc: Kill PROM console driver.") missed removing
> the declarations of the deleted prom_con structure and prom_con_init
> function from console.h. Kill them off now.
> 
> Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>

Applied, thank you.
