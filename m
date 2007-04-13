From: David Miller <davem@davemloft.net>
Date: Fri, 13 Apr 2007 23:10:51 +0000
Subject: Re: [TESTERS NEEDED]: Rewritten ESP driver
Message-Id: <20070413.161051.02291094.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20070412.233350.41640545.davem@davemloft.net>
In-Reply-To: <20070412.233350.41640545.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: "Tom \"spot\" Callaway" <tcallawa@redhat.com>
Date: Fri, 13 Apr 2007 15:18:59 -0500

> Tried the new esp driver on an SparcStation 4, with not much luck.
> 
> If you are willing to tackle this, and want esp_debug, please let me
> know.

I need esp_debug info, the very first command fails :)
I bet no interrupts are arriving, or something like that.

Please just enable everything with esp.esp_debug23

Thanks.
