From: Shannon Nelson <shannon.nelson@oracle.com>
Date: Wed, 25 Apr 2018 15:44:39 +0000
Subject: Re: [PATCH] sparc: vio: use put_device() instead of kfree()
Message-Id: <d16d5b54-90c9-3137-bc74-2b0d7135a928@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <a3722bda2eadf1ff229f73da6f0316f954956ae1.1524668025.git.arvind.yadav.cs@gmail.com>
In-Reply-To: <a3722bda2eadf1ff229f73da6f0316f954956ae1.1524668025.git.arvind.yadav.cs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arvind Yadav <arvind.yadav.cs@gmail.com>, davem@davemloft.net, jag.raman@oracle.com, liam.merwick@oracle.com
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

On 4/25/2018 7:56 AM, Arvind Yadav wrote:
> Never directly free @dev after calling device_register(), even
> if it returned an error. Always use put_device() to give up the
> reference initialized.
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
> ---
>   arch/sparc/kernel/vio.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/sparc/kernel/vio.c b/arch/sparc/kernel/vio.c
> index 1a0fa10..32bae68 100644
> --- a/arch/sparc/kernel/vio.c
> +++ b/arch/sparc/kernel/vio.c
> @@ -403,7 +403,7 @@ static struct vio_dev *vio_create_one(struct mdesc_handle *hp, u64 mp,
>   	if (err) {
>   		printk(KERN_ERR "VIO: Could not register device %s, err=%d\n",
>   		       dev_name(&vdev->dev), err);
> -		kfree(vdev);
> +		put_device(&vdev->dev);

Hmmm... I can see why the put_device() might be a good idea, but I think 
we still need the kfree() so as to not leak the memory that was 
kzalloc'd above for vdev.

sln

>   		return NULL;
>   	}
>   	if (vdev->dp)
> 
