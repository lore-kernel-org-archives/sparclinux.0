From: Kristoffer Glembo <kristoffer@gaisler.com>
Date: Mon, 02 Nov 2009 13:19:48 +0000
Subject: Re: Leon patches...
Message-Id: <4AEEDC74.5090603@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20091102.042421.72817389.davem@davemloft.net>
In-Reply-To: <20091102.042421.72817389.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

David Miller wrote:
> 
> What prevents all AMBA drivers from using openfirmware?
> 
> That would be the ideal situation.
> 

We are working on converting our device drivers to only depend on OF. 
Currently only the UART and Ethernet are done. I will send the Ethernet 
driver to netdev pretty soon. As Konrad said I posted the UART driver to 
linux-serial. I haven't gotten any response or feedback though, and I'm 
not sure who is the responsible maintainer for the serial subsystem. Is 
it possible to push it through sparc-next instead? In that case I can 
send the patch to this list.

Still, the code that scans the bus and creates the device tree must 
reside somewhere and that is what we want to clean up and put in 
drivers/ambapp.


Thanks,
Kristoffer
