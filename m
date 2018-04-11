From: Michal Hocko <mhocko@kernel.org>
Date: Wed, 11 Apr 2018 11:09:36 +0000
Subject: Re: [PATCH v3 2/2] mm: remove odd HAVE_PTE_SPECIAL
Message-Id: <20180411110936.GG23400@dhcp22.suse.cz>
List-Id: <sparclinux.vger.kernel.org>
References: <1523433816-14460-1-git-send-email-ldufour@linux.vnet.ibm.com>
 <1523433816-14460-3-git-send-email-ldufour@linux.vnet.ibm.com>
 <de6ee514-8b7e-24d0-a7ee-a8887e8b0ae9@c-s.fr>
 <93ed4fe4-dd1e-51be-948b-d53b16de21c5@linux.vnet.ibm.com>
 <278a5212-b962-9a3a-cc86-76cac744afab@c-s.fr>
 <32655c37-91cb-17aa-58e7-74254e2673a0@linux.vnet.ibm.com>
In-Reply-To: <32655c37-91cb-17aa-58e7-74254e2673a0@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Wed 11-04-18 12:32:07, Laurent Dufour wrote:
[...]
> Andrew, should I send a v4 or could you wipe the 2 __maybe_unsued when applying
> the patch ?

A follow $patch-fix should be better rather than post this again and
spam people with more emails.
-- 
Michal Hocko
SUSE Labs
