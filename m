From: David Miller <davem@davemloft.net>
Date: Tue, 13 Jun 2017 17:45:07 +0000
Subject: Re: [PATCH v1 04/12] sparc64: expand MDESC interface
Message-Id: <20170613.134507.182825488891018746.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <214c8e29bc065cb831b81a7e3f9e0b6f27c62f81.1497024216.git.jag.raman@oracle.com>
In-Reply-To: <214c8e29bc065cb831b81a7e3f9e0b6f27c62f81.1497024216.git.jag.raman@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Jag Raman <jag.raman@oracle.com>
Date: Tue, 13 Jun 2017 13:23:56 -0400

> Starting from [PATCH v1 11/12] in this series, md_node_info is
> cached in "struct vio_dev", and is later used to identify VIO
> devices in the MDESC. As a result, the name string in md_node_info
> would be used outside of mdesc_grab()/mdesc_release(). In such
> cases, caching a pointer to the property in MDESC may become a
> problem.

I strongly discourage this kind of string storage.

Use dynamically allocated memory if you have to, otherwise you
are:

1) Imposing arbitrary limits on string size.

2) Always consuming the "max" string length for every VIO
   device object.

We have a kstrdup_const() so please use something like that.

Thank you.
