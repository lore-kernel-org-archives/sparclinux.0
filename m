From: David Miller <davem@davemloft.net>
Date: Sat, 10 Jun 2017 21:34:27 +0000
Subject: Re: [PATCH v1 06/12] sparc64: add MDESC node name property to VIO device metadata
Message-Id: <20170610.173427.1068166680822846577.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <0be25e29ae56ab36a892ea186ce661dbb775459c.1497024216.git.jag.raman@oracle.com>
In-Reply-To: <0be25e29ae56ab36a892ea186ce661dbb775459c.1497024216.git.jag.raman@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Jag Raman <jag.raman@oracle.com>
Date: Fri,  9 Jun 2017 12:30:55 -0400

>  static struct vio_dev *vio_create_one(struct mdesc_handle *hp, u64 mp,
> -				      struct device *parent)
> +				      char *node_name, struct device *parent)

Make this "const char *node_name", and then:

> -	(void) vio_create_one(hp, node, &root_vdev->dev);
> +	(void) vio_create_one(hp, node, (char *)node_name, &root_vdev->dev);
 ...
> -		(void) vio_create_one(hp, node, &root_vdev->dev);
> +		(void) vio_create_one(hp, node, (char *)node_name,
> +				      &root_vdev->dev);

You won't need these casts.
