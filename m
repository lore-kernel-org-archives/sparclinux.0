From: Wim Coekaerts <wim.coekaerts@oracle.com>
Date: Thu, 28 Jan 2016 22:53:19 +0000
Subject: Re: [PATCH v6] Add sun4v_wdt watchdog driver
Message-Id: <56AA9BDF.6070907@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1454017572-5235-1-git-send-email-wim.coekaerts@oracle.com> <CAGRGNgWKzomgV2199r_Ym-DbGpeHz5dLwcWkC5-Lz+pftqBF9g@mail.gmail.com>
In-Reply-To: <CAGRGNgWKzomgV2199r_Ym-DbGpeHz5dLwcWkC5-Lz+pftqBF9g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Julian Calaby <julian.calaby@gmail.com>
Cc: wim@iguana.be, Guenter Roeck <linux@roeck-us.net>, linux-watchdog@vger.kernel.org, sparclinux <sparclinux@vger.kernel.org>

On 01/28/2016 02:50 PM, Julian Calaby wrote:
> Hi Wim,
>
> Sorry to keep iterating on this, but I noticed two small things you
> could improve:

yeah I was considering that although it makes the code a bit more 
readable but
fine happy to tweak that. no problem.

the static is definitely no longer needed after all the cleanup that 
happened.

