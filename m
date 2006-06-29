From: Martin Habets <errandir_news@mph.eclipse.co.uk>
Date: Thu, 29 Jun 2006 17:02:09 +0000
Subject: Re: [PATCH] sparc: remove sunzilog_console_init
Message-Id: <20060629170209.GA4800@palantir8>
List-Id: <sparclinux.vger.kernel.org>
References: <20060628141601.GA31139@palantir8>
In-Reply-To: <20060628141601.GA31139@palantir8>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Wed, Jun 28, 2006 at 11:35:41AM -0700, David Miller wrote:
> From: Martin Habets <errandir_news@mph.eclipse.co.uk>
> Date: Wed, 28 Jun 2006 15:34:02 +0100
> 
> > It was tested on a SS20 with the console on a sunzilog.
> 
> Where does the register_console() call occur then?
> 
> Oh, it happens in the serial layer because we set
> the ->cons member of sunzilog_reg right?

Yes, sunzilog_ports_init calls uart_add_one_port, which calls
register_console (at serial_core.c:2270) with the new SUNZILOG_CONSOLE
function.

It's all more convoluted, but effectively SUNZILOG_CONSOLE has replaced
sunzilog_console_init.

>> I did some transformations over the last year that somehow
>> made this function no longer invoked, when it should be,
>> and I need to figure that out and fix the problem properly.

While it is possible to keep the function and call it like before
from sunzilog_ports_init, personally I don't see the point. Better
call SUNZILOG_CONSOLE if that's what you realy want.

-- 
Martin
