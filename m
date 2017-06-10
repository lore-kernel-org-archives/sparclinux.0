From: David Miller <davem@davemloft.net>
Date: Sat, 10 Jun 2017 22:45:18 +0000
Subject: Re: [RFC] sparc64: Add virtual console server support
Message-Id: <20170610.184518.412609942618991143.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <7e19207357c55e200ea2ebb36a5bf9ebd509ff4c.1497024581.git.jag.raman@oracle.com>
In-Reply-To: <7e19207357c55e200ea2ebb36a5bf9ebd509ff4c.1497024581.git.jag.raman@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Jag Raman <jag.raman@oracle.com>
Date: Fri,  9 Jun 2017 12:32:02 -0400

> diff --git a/arch/sparc/include/asm/vio.h b/arch/sparc/include/asm/vio.h
> index d1c47e9..fca4a91 100644
> --- a/arch/sparc/include/asm/vio.h
> +++ b/arch/sparc/include/asm/vio.h
> @@ -52,6 +52,7 @@ struct vio_ver_info {
>  #define VDEV_NETWORK_SWITCH	0x02
>  #define VDEV_DISK		0x03
>  #define VDEV_DISK_SERVER	0x04
> +#define VDEV_CONSOLE_CON	0x05
>  
>  	u8			resv1[3];
>  	u64			resv2[5];
> @@ -282,6 +283,14 @@ struct vio_dring_state {
>  	struct ldc_trans_cookie	cookies[VIO_MAX_RING_COOKIES];
>  };
>  
> +#define	VIO_TAG_SIZE		(sizeof(struct vio_msg_tag))
> +#define	VIO_VCC_MTU_SIZE	(LDC_PACKET_SIZE - 8)

This "8" is just VIO_TAG_SIZE right?  So just use that.

> +#define	TIMER_SET(v, x, t)	((v)->x##_timer.expires = (t))
> +#define	TIMER_CLEAR(v, x)	((v)->x##_timer.expires = 0)
> +#define	TIMER_ACTIVE(v, x)	((v)->x##_timer.expires)

I see you use this like:

> +	TIMER_SET(vcc, rx, jiffies + 1);
> +	add_timer(&vcc->rx_timer);

Please juse use "mod_timer()" which is also thread safe and also works
even if the timer is pending.

The TIMER_CLEAR() operation doesn't even do anything.

There is an interface for seeing if a timer is active "timer_pending()"

So please remove these special timer macros and just use the provided
standard kernel interfaces.

> +static int vcc_ldc_read(struct vcc *vcc)
> +{
> +	struct vio_driver_state *vio = &vcc->vio;
> +	struct tty_struct *tty;
> +	struct vio_vcc pkt;
> +	int rv = 0;
> +	vccdbg("%s\n", __func__);

Please put an empty line between local variable declarations and code.

> +static void vcc_rx_timer(unsigned long arg)
> +{
> +	struct vcc *vcc;
> +	struct vio_driver_state *vio;
> +	unsigned long flags;
> +	int rv;

Please order local variable from longest to shortest line.

> +static void vcc_tx_timer(unsigned long arg)
> +{
> +	struct vcc *vcc;
> +	struct vio_vcc *pkt;
> +	unsigned long flags;
> +	int tosend = 0;
> +	int rv;

Likewise.

> +static void vcc_event(void *arg, int event)
> +{
> +	struct vcc *vcc = arg;
> +	struct vio_driver_state *vio = &vcc->vio;
> +	unsigned long flags;
> +	int rv;

Likewise.

> +static ssize_t vcc_sysfs_domain_show(struct device *device,
> +	struct device_attribute *attr, char *buf)
> +{
> +	int rv;
> +	struct vcc *vcc;

Likewise.

> +static int vcc_send_ctl(struct vcc *vcc, int ctl)
> +{
> +	int rv;
> +	struct vio_vcc pkt;

Likewise.

> +static ssize_t vcc_sysfs_break_store(struct device *device,
> +	struct device_attribute *attr, const char *buf, size_t count)
> +{
> +	int rv = count;
> +	int brk;
> +	unsigned long flags;
> +	struct vcc *vcc;

Likewise.

> +static int vcc_probe(struct vio_dev *vdev,
> +	const struct vio_device_id *id)
> +{
> +	int rv;
> +	char *name;
> +	const char *domain;
> +	struct vcc *vcc;
> +	struct device *dev;
> +	struct mdesc_handle *hp;
> +	u64 node;

Likewise.

> +	/*
> +	 * Register the device using the port ID as the index.
> +	 * TODO - Device registration should probably be done last
> +	 * since the device is "live" as soon as it's called (and
> +	 * calls into the tty/vcc infrastructure can start
> +	 * happening for this device immediately afterwards).
> +	 */
> +	dev = tty_register_device(vcc_tty_driver, vdev->port_id, &vdev->dev);
> +	if (IS_ERR(dev)) {
> +		rv = PTR_ERR(dev);
> +		goto free_ldc;
> +	}

I agree, you should probably only make the device visible after you have set
everything else up.  It means that unwinding from registry error is a bit more
tedious but I am pretty sure registering early like this is going to cause
problems.

> +static int vcc_open(struct tty_struct *tty, struct file *filp)
> +{
> +	struct vcc *vcc;
> +	struct tty_port *port;
> +	int rv;

Local variable ordering again.

> +static void vcc_hangup(struct tty_struct *tty)
> +{
> +	struct vcc *vcc;
> +	struct tty_port *port;

Likewise.

> +static int vcc_write(struct tty_struct *tty,
> +		const unsigned char *buf, int count)
> +{
> +	struct vcc *vcc;
> +	struct vio_vcc *pkt;
> +	unsigned long flags;
> +	int total_sent = 0;
> +	int tosend = 0;
> +	int rv = -EINVAL;

Likewise.

> +static int vcc_break_ctl(struct tty_struct *tty, int state)
> +{
> +	struct vcc *vcc;
> +	unsigned long flags;

Likewise.

> +static int vcc_install(struct tty_driver *driver, struct tty_struct *tty)
> +{
> +	int ret;
> +	struct vcc *vcc;
> +	struct tty_port *port;

Likewise.
