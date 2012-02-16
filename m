From: mroos@linux.ee
Date: Thu, 16 Feb 2012 21:08:05 +0000
Subject: Re: OF-related boot crash in 3.3.0-rc3-00188-g3ec1e88
Message-Id: <alpine.SOC.1.00.1202162307250.19246@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <20120213080618.GA11077@ponder.secretlab.ca> <alpine.SOC.1.00.1202131119040.1488@math.ut.ee> <20120213214623.GJ11077@ponder.secretlab.ca> <20120213.195835.1573147101037168145.davem@davemloft.net>
 <CACxGe6tqsYs8-n2Q+EGGekS6wOOYYXUvUbEu6sfQ7U3--Gyjnw@mail.gmail.com>
In-Reply-To: <CACxGe6tqsYs8-n2Q+EGGekS6wOOYYXUvUbEu6sfQ7U3--Gyjnw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Grant Likely <grant.likely@secretlab.ca>
Cc: David Miller <davem@davemloft.net>, rob.herring@calxeda.com, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

> Definitely not right!  It would be interesting to add a printk() to
> of_find_node_by_phandle() or of_find_node_by_path() to blast out the
> node names as it traverses the tree.  That could help track down
> corruption.

[    0.000000] of_find_node_by_path: /chosen
[    0.000000] of_find_node_by_path: /aliases                      ¥_6䥷~ê7\eý+õï*¢ꢏñ?¿sM       ý{
aliases000000] ò7find_node_by_path: ðÑÔ_Bÿ
[    0.000000] Unable to handle kernel NULL pointer dereference

-- 
Meelis Roos (mroos@linux.ee)
