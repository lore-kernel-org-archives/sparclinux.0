From: David Miller <davem@davemloft.net>
Date: Tue, 12 Jan 2010 09:59:58 +0000
Subject: Re: [PATCH] SPARC: Simplify param.h by simply including
Message-Id: <20100112.015958.146880763.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LFD.2.00.0912300356540.13010@localhost>
In-Reply-To: <alpine.LFD.2.00.0912300356540.13010@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Wed, 30 Dec 2009 14:14:37 +0100

> On Wed, Dec 30, 2009 at 03:58:39AM -0500, Robert P. J. Day wrote:
>> 
>> Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>
>> 
>> ---
>> 
>>   override the only difference, EXEC_PAGESIZE, then include the
>> generic version.
> 
> Looks good.
> 
> Reviewed-by: Sam Ravnborg <sam@ravnborg.org>

Applied, thanks everyone.
