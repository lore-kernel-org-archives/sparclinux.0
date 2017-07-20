From: Jim Quigley <jim.quigley@oracle.com>
Date: Thu, 20 Jul 2017 20:19:52 +0000
Subject: Re: [PATCH] sparc64: prevent sunvdc panic when mpgroup disk added to guest domain
Message-Id: <8a94d2d7-d0a2-d8b2-a60f-fcfb05b004dc@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1500546590-109040-1-git-send-email-Jim.Quigley@oracle.com>
In-Reply-To: <1500546590-109040-1-git-send-email-Jim.Quigley@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 20/07/2017 20:35, David Miller wrote:
> From: Jim Quigley <Jim.Quigley@oracle.com>
> Date: Thu, 20 Jul 2017 06:29:50 -0400
>
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
> Please use "sunvdc: " as your subsystem prefix in your subject line.

     Will do.
>
>> +	if ((vdev->dev_no = port_data->dev_no) &&
>> +	    (!(strcmp((char *)&vdev->type, port_data->type))) &&
> vdev->type is a char pointer already, there is no need for this cast
> and it's looks awful as well :-)

     vdev->type is defined as

                 char                    type[VIO_MAX_TYPE_LEN];

     and removing the cast results in :-

drivers/block/sunvdc.c: In function 'vdc_device_probed':
drivers/block/sunvdc.c:891: warning: passing argument 1 of 'strcmp' from 
incompatible pointer type
./include/linux/string.h:42: note: expected 'const char *' but argument 
is of type 'char (*)[32]'

>
>> +		return 1;
>> +	} else {
>> +		return 0;
> Please use "bool" as the return type and true/false here.

     It needs to be an int for device_find_child().

drivers/block/sunvdc.c:921: warning: passing argument 3 of 
'device_find_child' from incompatible pointer type
./include/linux/device.h:1125: note: expected 'int (*)(struct device *, 
void *)' but argument is of type 'bool (*)(struct device *, void *)'


>
>> +	port_data.type = (char *)&vdev->type;
> Again, no need for this cast.

     The same as above :-

drivers/block/sunvdc.c:918: warning: assignment from incompatible 
pointer type


>
>> +	dev = device_find_child(vdev->dev.parent, (void *)&port_data,
> You also never need to explicitly cast to "void *", it will implicitly
> be done if that is the argument type.

     Yes.

     thanks

     regards

     Jim Q.
