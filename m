From: David Miller <davem@davemloft.net>
Date: Wed, 17 Sep 2014 01:27:31 +0000
Subject: Re: [PATCH V2] sparc64: T5 PMU
Message-Id: <20140916.212731.606930363354978554.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1410876546-19180-1-git-send-email-bpicco@meloft.net>
In-Reply-To: <1410876546-19180-1-git-send-email-bpicco@meloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Bob Picco <bpicco@meloft.net>
Date: Tue, 16 Sep 2014 10:09:06 -0400

> From: bob picco <bpicco@meloft.net>
> 
> The T5 (niagara5) has different PCR related HV fast trap values and a new
> HV API Group. This patch utilizes these and shares when possible with niagara4.
> 
> We use the same sparc_pmu niagara4_pmu. Should there be new effort to
> obtain the MCU perf statistics then this would have to be changed.
> 
> Cc: sparclinux@vger.kernel.org
> Signed-off-by: Bob Picco <bob.picco@oracle.com>
> ---
> V2: Hopefully have the programming style correct.

Looks good, applied, although:

> @@ -215,6 +244,9 @@ static int __init register_perf_hsvc(void)
>  			perf_hsvc_group = HV_GRP_VT_CPU;
>  			break;
>  
> +		case SUN4V_CHIP_NIAGARA5:
> +			perf_hsvc_group = HV_GRP_T5_CPU;
> +			break;
>  		default:
>  			return -ENODEV;
>  		}

I added an empty line bfore "default:"

Thanks!
