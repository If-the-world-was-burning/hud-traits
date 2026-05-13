/obj/item/organ/internal/cyberimp/eyes
	name = "cybernetic eye implant"
	desc = "Implants for your eyes."
	icon_state = "eye_implant"
	implant_overlay = "eye_implant_overlay"
	slot = ORGAN_SLOT_EYES
	zone = BODY_ZONE_PRECISE_EYES
	w_class = WEIGHT_CLASS_TINY

// HUD implants
/obj/item/organ/internal/cyberimp/eyes/hud
	name = "HUD implant"
	desc = "These cybernetic eyes will display a HUD over everything you see. Maybe."
	slot = ORGAN_SLOT_HUD
	actions_types = list(/datum/action/item_action/toggle_hud)
	var/HUD_traits = list()
	/// Whether the HUD implant is on or off
	var/toggled_on = TRUE
	//For toggling a trait related hud.
	var/HUD_trait_toggle = null

/obj/item/organ/internal/cyberimp/eyes/hud/proc/toggle_hud(mob/living/carbon/eye_owner)

	if(toggled_on)
		if(HUD_trait_toggle)
			REMOVE_TRAIT(eye_owner, HUD_trait_toggle, ORGAN_TRAIT)
		toggled_on = FALSE
		eye_owner.add_traits(HUD_traits, ORGAN_TRAIT)
		to_chat(eye_owner, "You blink twice, toggling your [name] off.")
		return
	toggled_on = TRUE
	eye_owner.remove_traits(HUD_traits, ORGAN_TRAIT)
	balloon_alert(eye_owner, "hud enabled")
		if(HUD_trait_toggle)
			ADD_TRAIT(eye_owner, HUD_trait_toggle, ORGAN_TRAIT)

/obj/item/organ/internal/cyberimp/eyes/hud/Insert(mob/living/carbon/eye_owner, special = FALSE, drop_if_replaced = TRUE)
	. = ..()
	if(!.)
		return
	if(HUD_trait_toggle)
		ADD_TRAIT(eye_owner, HUD_trait_toggle, ORGAN_TRAIT)
	eye_owner.add_traits(HUD_traits, ORGAN_TRAIT)

/obj/item/organ/internal/cyberimp/eyes/hud/Remove(mob/living/carbon/eye_owner, special = FALSE)
	. = ..()
	if(HUD_trait_toggle)
		REMOVE_TRAIT(eye_owner, HUD_trait_toggle, ORGAN_TRAIT)
	eye_owner.remove_traits(HUD_traits, ORGAN_TRAIT)
	toggled_on = FALSE

/obj/item/organ/internal/cyberimp/eyes/hud/medical
	name = "medical HUD implant"
	desc = "These cybernetic eye implants will display a medical HUD over everything you see."
	icon_state = "eye_implant_medical"
	HUD_traits = list(TRAIT_MEDICAL_HUD)

/obj/item/organ/internal/cyberimp/eyes/hud/security
	name = "security HUD implant"
	desc = "These cybernetic eye implants will display a security HUD over everything you see."
	icon_state = "eye_implant_security"
	HUD_traits = list(TRAIT_SECURITY_HUD)

/obj/item/organ/internal/cyberimp/eyes/hud/diagnostic
	name = "diagnostic HUD implant"
	desc = "These cybernetic eye implants will display a diagnostic HUD over everything you see."
	icon_state = "eye_implant_diagnostic"
	HUD_traits = list(TRAIT_DIAGNOSTIC_HUD, TRAIT_BOT_PATH_HUD)

/obj/item/organ/internal/cyberimp/eyes/hud/security/syndicate
	name = "Contraband Security HUD Implant"
	desc = "A Cybersun Industries brand Security HUD Implant. These illicit cybernetic eye implants will display a security HUD over everything you see."
	icon_state = "eye_implant_syndicate"
	organ_flags = parent_type::organ_flags | ORGAN_HIDDEN

/obj/item/organ/internal/cyberimp/eyes/hud/pathology //Patho goggles dont use actual huds so we have to use HUD_trait_toggle
	name = "Pathology HUD implant"
	desc = "These cybernetic eye implants will reveal any pathogens in the area and their chemical regrants."
	HUD_trait = TRAIT_REAGENT_SCANNER
	HUD_trait_toggle = TRAIT_VIRUS_SCANNER
	icon_state = "eye_implant_pathology"

/obj/item/organ/internal/cyberimp/eyes/fakehud   // We use fakehud to prevent unnessecary buttons
	name = "HUD implant"
	desc = "These cybernetic eyes won't display a HUD over anything you see. Ever."
	var/HUD_trait = null

/obj/item/organ/internal/cyberimp/eyes/fakehud/science
	name = "Science HUD implant"
	desc = "These cybernetic eye implants will allows you to see the exact chemical regrants and what they break down into."
	icon_state = "eye_implant_science"
	slot = ORGAN_SLOT_HUD

/obj/item/organ/internal/cyberimp/eyes/fakehud/science/Insert(mob/living/carbon/eye_owner, special = FALSE, drop_if_replaced = TRUE)
	. = ..()
	if(!.)
		return
	ADD_TRAIT(eye_owner, TRAIT_REAGENT_SCANNER, ORGAN_TRAIT)
	ADD_TRAIT(eye_owner, TRAIT_RESEARCH_SCANNER, ORGAN_TRAIT)

/obj/item/organ/internal/cyberimp/eyes/fakehud/science/Remove(mob/living/carbon/eye_owner, special = FALSE)
	. = ..()
	REMOVE_TRAIT(eye_owner, TRAIT_REAGENT_SCANNER, ORGAN_TRAIT)
	REMOVE_TRAIT(eye_owner, TRAIT_RESEARCH_SCANNER, ORGAN_TRAIT)
