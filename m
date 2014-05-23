From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 23 May 2014 20:21:37 +0000
Subject: Re: [PATCH] sbus: Introduce the use of the managed version of kzalloc
Message-Id: <20140523202136.GA17307@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20140522203536.GA16457@himangi-Dell>
 <20140523201703.GA17295@ravnborg.org>
In-Reply-To: <20140523201703.GA17295@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Himangi Saraogi <himangi774@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, julia.lawall@lip6.fr

On Fri, May 23, 2014 at 10:17:03PM +0200, Sam Ravnborg wrote:
> Hi Himangi.
> 
> On Fri, May 23, 2014 at 02:05:36AM +0530, Himangi Saraogi wrote:
> > This patch moves data allocated using kzalloc to managed data allocated
> > using devm_kzalloc and cleans now unnecessary kfrees in probe and remove
> > functions. The header file is added to make the devm function explicitly
> > available. Also, unnecessary assignment statements and labels are
> > removed.

Another note.
This patch touches only the display7seg dirver, so please prefix
your patch with "display7seg: bla bla"

	Sam
