From: Jim Quigley <jim.quigley@oracle.com>
Date: Thu, 20 Jul 2017 20:21:45 +0000
Subject: Re: [PATCH] sparc64: prevent sunvdc panic when mpgroup disk added to guest domain
Message-Id: <89f67a70-c5c4-62ae-49ee-278fbb411f7a@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1500546590-109040-1-git-send-email-Jim.Quigley@oracle.com>
In-Reply-To: <1500546590-109040-1-git-send-email-Jim.Quigley@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 20/07/2017 20:47, Sam Ravnborg wrote:
> Hi Jim.
>
> A few nitpicks.
>
> On Thu, Jul 20, 2017 at 06:29:50AM -0400, Jim Quigley wrote:
>> Using mpgroup to define multiple paths for a virtual disk causes multiple
>> virtual-device-port ports to be created for that virtual device.
>> Each virtual-device-port port then gets a vdisk created for it by the Linux
>> sunvdc driver. As mpgroup is not supported by the Linux sunvdc driver it
>> cannot handle multiple ports for a single vdisk, leading to a kernel panic
>> at startup.
>>
>> This fix prevents more than one vdisk per virtual-device-port being created
>> until full virtual disk multipathing (mpgroup) support is implemented.
>>
>> Signed-off-by: Jim Quigley <Jim.Quigley@oracle.com>
>> Reviewed-by: Shannon Nelson <shannon.nelson@oracle.com>
>> Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
>> Reviewed-by: Aaron Young <aaron.young@oracle.com>
>> +
>> +/*
>> + * Determine whether the VIO device is part of an mpgroup
>> + * by locating all the virtual-device-port nodes associated
>> + * with the parent virtual-device node for the VIO device
>> + * and checking whether any of these nodes are vdc-ports
>> + * which have already been configured.
>> + *
>> + * Returns true if this device is part of an mpgroup and has
>> + * already been probed.
>> + */
> This filel uses "netdev" style for comments.
> Change coments to look like this:
>
> /* Bla bla.
>   * More bla blah.
>   */

     Will do.
>
>
>> +static bool vdc_port_mpgroup_check(struct vio_dev *vdev)
>> +{
>> +	struct vdc_check_port_data port_data;
>> +	struct device *dev;
>> +
>> +	port_data.dev_no = vdev->dev_no;
>> +	port_data.type = (char *)&vdev->type;
> Cast not needed?

     It appears to be needed,

drivers/block/sunvdc.c:918: warning: assignment from incompatible 
pointer type


     thanks

     regards

     Jim Q.



>
> 	Sam


