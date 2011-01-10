From: David Miller <davem@davemloft.net>
Date: Mon, 10 Jan 2011 08:32:10 +0000
Subject: Re: [PATCH] atyfb: Fix bootup hangs on sparc64.
Message-Id: <20110110.003210.108780476.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20110105.130959.260100853.davem@davemloft.net>
In-Reply-To: <20110105.130959.260100853.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Mon, 10 Jan 2011 09:30:13 +0100

> The display I see on the monitor after the hand-over complete is
> a few coloumns of duplicated text.
> As my primitive root filesystem halts I cannot produce any output.
> 
> When I enter the prom console I continue to see the same text
> in the background.
> If it is on any help I can try to take a picture.

What kind of monitor the machine is hooked up to?  I think this may
be key to reproducing the problem and perhaps I have something similar
here for testing.

