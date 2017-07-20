From: David Miller <davem@davemloft.net>
Date: Thu, 20 Jul 2017 19:35:37 +0000
Subject: Re: [PATCH] sparc64: prevent sunvdc panic when mpgroup disk added to guest domain
Message-Id: <20170720.123537.753986315503458559.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1500546590-109040-1-git-send-email-Jim.Quigley@oracle.com>
In-Reply-To: <1500546590-109040-1-git-send-email-Jim.Quigley@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Jim Quigley <Jim.Quigley@oracle.com>
Date: Thu, 20 Jul 2017 06:29:50 -0400

> Using mpgroup to define multiple paths for a virtual disk causes multiple
> virtual-device-port ports to be created for that virtual device.
> Each virtual-device-port port then gets a vdisk created for it by the Linux
> sunvdc driver. As mpgroup is not supported by the Linux sunvdc driver it
> cannot handle multiple ports for a single vdisk, leading to a kernel panic
> at startup.
> 
> This fix prevents more than one vdisk per virtual-device-port being created
> until full virtual disk multipathing (mpgroup) support is implemented.
> 
> Signed-off-by: Jim Quigley <Jim.Quigley@oracle.com>
> Reviewed-by: Shannon Nelson <shannon.nelson@oracle.com>
> Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
> Reviewed-by: Aaron Young <aaron.young@oracle.com>

Please use "sunvdc: " as your subsystem prefix in your subject line.

> +	if ((vdev->dev_no = port_data->dev_no) &&
> +	    (!(strcmp((char *)&vdev->type, port_data->type))) &&

vdev->type is a char pointer already, there is no need for this cast
and it's looks awful as well :-)

> +		return 1;
> +	} else {
> +		return 0;

Please use "bool" as the return type and true/false here.

> +	port_data.type = (char *)&vdev->type;

Again, no need for this cast.

> +	dev = device_find_child(vdev->dev.parent, (void *)&port_data,

You also never need to explicitly cast to "void *", it will implicitly
be done if that is the argument type.
