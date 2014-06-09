From: Aaro Koskinen <aaro.koskinen@iki.fi>
Date: Mon, 09 Jun 2014 20:59:17 +0000
Subject: Linux 3.15: SPARC serial console regression
Message-Id: <20140609205917.GA913@drone.musicnaut.iki.fi>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Seth Bollinger <sethb@digi.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

Hi,

While testing the final 3.15, I noticed the serial console (sunsab)
does not work anymore on Sun Ultra.

It will tx fine the console output during the boot. But then I try
to type something e.g. at the login: prompt, it behaves oddly:
it re-transmits some old output, and then stalls for a few secs, usually
for each character. Typed characters are however received correctly.
But the console is impossible to use...

I bisected this to:

717f3bbab3c7628736ef738fdbf3d9a28578c26c is the first bad commit
commit 717f3bbab3c7628736ef738fdbf3d9a28578c26c
Author: Seth Bollinger <sethb@digi.com>
Date:   Tue Mar 25 12:55:37 2014 -0500

    serial_core: Fix conditional start_tx on ring buffer not empty

A.
