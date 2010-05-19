From: "Alex Mach" <alexvm12e@mail.ru>
Date: Wed, 19 May 2010 08:53:22 +0000
Subject: Re: sun4v_data_access_exception during access to hardware
Message-Id: <436385D563A64675A3B9316F01E446AA@alexm>
List-Id: <sparclinux.vger.kernel.org>
References: <20100513.042552.242119562.davem@davemloft.net>
In-Reply-To: <20100513.042552.242119562.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


> Only drivers/net/niu.c does, it does the physical address handling by 
> hand.

I'd like try to modify ethoc driver according to niu driver. As I understand 
I've to add some device node(let's call it by Ethoc f.e) to OBP device tree 
as you wrote in one of previous mail. So could you get example of the node 
for niu device, please?

Thanks,
Alex. 

